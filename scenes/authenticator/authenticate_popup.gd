extends Panel

@onready var incorrect: Label = $INCORRECT
@onready var line_edit: LineEdit = $LineEdit
@onready var timer: Timer = $Timer
@onready var authenticate_popup: Panel = $"."
@onready var wrong: AudioStreamPlayer = $INCORRECT/wrong
@onready var close_audio: AudioStreamPlayer = $close_audio

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

func _ready() -> void:
	authenticate_popup.visible = false
func _process(delta: float) -> void:
	if is_dragging:
		global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
		clamp_window_inside_viewport()
func _on_close_pressed() -> void:
	authenticate_popup.visible = false
	close_audio.play()

func _on_timer_timeout() -> void:
	incorrect.visible = false

func _on_confirm_pressed() -> void:
	authenticate()


func _on_resizehandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false

func clamp_window_inside_viewport() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var position = global_position
	var object_size = size * 3
	
	position.x = clamp(position.x, 0, viewport_size.x - object_size.x)
	position.y = clamp(position.y, 0, viewport_size.y - object_size.y)
	global_position = position

func _on_line_edit_text_submitted(new_text: String) -> void:
	authenticate()

func authenticate():
	if line_edit.text == "cubigor":
		authenticate_popup.visible = false
		get_tree().call_group("authentication","_on_authenticate_popup_authenticated")
	if line_edit.text == "max9th":
		authenticate_popup.visible = false
		get_tree().call_group("authentication","_on_authenticated")
	elif line_edit.text != "cubigor" and line_edit.text != "max9th":
		incorrect.visible = true
		timer.start()
		line_edit.text = ""
		wrong.play()
