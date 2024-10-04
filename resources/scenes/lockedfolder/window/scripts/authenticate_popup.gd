extends Panel

@onready var incorrect: Label = $INCORRECT
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit
@onready var timer: Timer = $Timer
@onready var wrong: AudioStreamPlayer = $INCORRECT/wrong
@onready var close_audio: AudioStreamPlayer = $close/close_audio
@export var visible_window: bool

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2
var easter: bool
var swearing = false

func _ready() -> void:
	if visible_window == false:
		visible = false
	else:
		visible = true
	incorrect.visible = false
func _process(_delta: float) -> void:
	if is_dragging:
		global_position = Windowz.handle_dragging(start_drag_position, mouse_start_drag_position, get_global_mouse_position())
	if easter == false and swearing == false:
		incorrect.text = "!!Senha incorreta!!"

func _on_close_pressed() -> void:
	visible = false
	close_audio.play()

func _on_timer_timeout() -> void:
	incorrect.visible = false
	swearing = false

func _on_confirm_pressed() -> void:
	authenticate()

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false

func _on_line_edit_text_submitted(_new_text: String) -> void:
	authenticate()

func authenticate():
	var user_input = line_edit.text
	if easter == false:
		match user_input:
			"cubigor":
				authenticated()
			"max9th":
				authenticated()
			"lies":
				authenticated()
			"ass":
				swears()
			"merda":
				swears()
			"pinto":
				swears()
			"rola":
				swears()
			"pussy":
				swears()
			"xereca":
				swears()
			"pika":
				swears()
			"porra":
				swears()
			_:
				incorrect.visible = true
				timer.start()
				line_edit.text = ""
				wrong.play()
	elif easter == true:
		incorrect.text = "!!IT'S EASTER ALREADY!!"
		incorrect.visible = true
		timer.start()
		wrong.play()

func authenticated():
	var user_input = line_edit.text
	visible = false
	get_tree().call_group("authentication", "_on_authenticated" + "_" + str(user_input))
	easter = true

func _on_mainmenu_stop() -> void:
	easter = false

func swears():
	swearing = true
	incorrect.text = "!!EW MANO!"
	incorrect.visible = true
	timer.start()
	line_edit.text = ""
	wrong.play()
