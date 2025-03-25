@tool
class_name popup_window_vos extends window_vos

@export var has_pwd_query: bool:
	set = set_has_pwd_query
@export var pwd_input_box: LineEdit:
	set = set_pwd_input_box

@export var popup_text_label: Label

@onready var incorrect_message: HBoxContainer = %IncorrectMsg
@onready var timer: Timer = $Other_components/Timer

func set_pwd_input_box(value):
	pwd_input_box = value
	pwd_input_box.connect("text_submitted", verify)

func set_has_pwd_query(value):
	has_pwd_query = value
	if has_pwd_query:
		pwd_input_box.show()
	else:
		pwd_input_box.hide()

func _ready() -> void:
	self.position = (viewport_size / 2 - self.size / 2) + Vector2(0, panel_height/2)

func verify(user_input: String):
	print("a")
	match user_input:
		"cubigor":
			Corec.clear_popups.emit()
			Corec.start_event(
				Corec.crt_shader,
				Corec.default_background, "res://Files/audio/Cubigor theme.mp3",
				Color("1b2130"),
				true,
				"res://Files/scenes/others/easter/Donigor.scn"
			)

		"max9th":
			Corec.clear_popups.emit()
			Corec.start_event()

		"nightcity":
			Corec.clear_popups.emit()
			Corec.start_event()

		"the silent remains":
			Corec.clear_popups.emit()
			Corec.start_event(
				"res://Files/shaders/vignette.tres",
				"res://Files/sprites/belathazar.png",
				"res://Files/audio/morse.wav"
			)

		"labobarco":
			Corec.play_secondary_track("res://Files/audio/Building_Stuff.mp3")

		"deziangle":
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
