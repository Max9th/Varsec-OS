extends Panel

@onready var incorrect: Label = $INCORRECT
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit
@onready var timer: Timer = $Timer
@onready var wrong: AudioStreamPlayer = $INCORRECT/wrong
@onready var close_audio: AudioStreamPlayer = $close/close_audio

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2
var easter: bool

func _ready() -> void:
	visible = false
	incorrect.visible = false
func _process(_delta: float) -> void:
	if is_dragging:
		global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
		clamp_window_inside_viewport()
func _on_close_pressed() -> void:
	visible = false
	close_audio.play()

func _on_timer_timeout() -> void:
	incorrect.visible = false

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

func clamp_window_inside_viewport() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var position2 = global_position
	var object_size = size * 3
	
	position2.x = clamp(position2.x, 0, viewport_size.x - object_size.x)
	position2.y = clamp(position2.y, 0, viewport_size.y - object_size.y)
	global_position = position2

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
	
