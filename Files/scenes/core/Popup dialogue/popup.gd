class_name popup_window_vos extends window_vos

@export var has_pwd_query: bool
@export var pwd_input_box: LineEdit
@export var window_name: String
@export_multiline var window_text: String
@export var window_text_label: Label

@onready var incorrect_message: HBoxContainer = %IncorrectMsg
@onready var timer: Timer = $Other_components/Timer

func _ready() -> void:
	super._ready()
	configure_popup()
	self.position = (viewport_size / 2 - self.size / 2) + Vector2(0, 40)

func _process(delta: float) -> void:
	super ._process(delta)

func configure_popup():
	window_name_label.text = window_name
	window_text_label.text = window_text
	if has_pwd_query:
		pwd_input_box.show()
	else:
		pwd_input_box.hide()

func _on_line_edit_text_submitted(new_text: String) -> void:
	verify(new_text)

func verify(user_input: String):
		match user_input:
			"cubigor":
				Corec.stop_event()
				Corec.clear_popups.emit()
				Corec.start_event(Corec.crt_shader, Corec.default_background, "res://Files/audio/Cubigor theme.mp3", Color("1b2130"), true, "res://Files/scenes/others/easter/Donigor.scn")
				Corec.hide_os_billboards_signal.emit()

			"max9th":
				Corec.stop_event()
				Corec.clear_popups.emit()
				Corec.start_event()

			"nightcity":
				Corec.stop_event()
				Corec.clear_popups.emit()
				Corec.start_event()

			"the silent remains":
				Corec.stop_event()
				Corec.clear_popups.emit()
				Corec.start_event("res://Files/shaders/vignette.tres", "res://Files/sprites/belathazar.png", "res://Files/audio/morse.wav" )

			"labobarco":
				Corec.play_secondary_track("res://Files/audio/Building_Stuff.mp3")
			"deziangle":
				Corec.stop_event()
				Corec.start_event()

			"fuck":
				pass
			"no u":
				pass
			"bitch":
				pass
			_:
				incorrect_message.visible = true
				timer.start()
				pwd_input_box.text = ""
				#if can_play == true:
				audioplayer.play()
				#line_edit.editable = false
				#can_play = false


func _on_timer_timeout() -> void:
	incorrect_message.hide()
