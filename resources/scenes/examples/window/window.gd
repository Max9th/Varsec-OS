extends Panel

@onready var nelixwindow: Panel = $"."
@onready var close_audio: AudioStreamPlayer = $close_audio

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

var is_maximized: bool
var old_unmaximized_position: Vector2
var old_unmaximized_size: Vector2

func _ready() -> void:
	nelixwindow.visible = false
func _process(_delta: float) -> void:
	if is_dragging:
		global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
		clamp_window_inside_viewport()

func _on_close_pressed() -> void:
	nelixwindow.visible = false
	close_audio.play()

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
