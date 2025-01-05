class_name popup_window_vos extends window_vos

@export var has_pwd_query: bool
@export var pwd_input_box: LineEdit
@export var window_name: String
@export_multiline var window_text: String
@export var window_text_label: Label

func _ready() -> void:
	super._ready()
	configure_popup()
	self.position = viewport_size / 2 - self.size / 2

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
				authenticate()
			"max9th":
				authenticate()
			"nightcity":
				authenticate()
			"labobarco":
				pass
			"deziangle":
				authenticate()
			"fuck":
				swears()
			"no u":
				swears()
			"bitch":
				swears()
			#_:
				#incorrect.visible = true
				#timer.start()
				#line_edit.text = ""
				#if can_play == true:
					#wrong.play()
				#timer_incorrect.start()
				#line_edit.editable = false
				#can_play = false

func authenticate():
	pass

func swears():
	pass
