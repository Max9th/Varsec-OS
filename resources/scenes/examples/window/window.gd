extends Panel

class_name WindowController

@onready var close_audio: AudioStreamPlayer = $close_audio

var is_dragging: bool = false
var is_maximized: bool = false
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2
var old_unmaximized_position: Vector2
var old_unmaximized_size: Vector2

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if is_dragging:
		handle_dragging()

func _on_close_pressed() -> void:
	close_window()

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			start_dragging()
		else:
			stop_dragging()

func handle_dragging() -> void:
	global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
	clamp_window_inside_viewport()

func start_dragging() -> void:
	is_dragging = true
	start_drag_position = global_position
	mouse_start_drag_position = get_global_mouse_position()

func stop_dragging() -> void:
	is_dragging = false

func close_window() -> void:
	visible = false
	close_audio.play()

func clamp_window_inside_viewport() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var position2 = global_position
	var object_size = size * 3
	position2.x = clamp(position2.x, 0, viewport_size.x - object_size.x)
	position2.y = clamp(position2.y, 0, viewport_size.y - object_size.y)
	global_position = position2

func _on_maximize_pressed() -> void:
	if is_maximized:
		restore_window()
	else:
		prepare_for_maximize()
		animate_maximize()

func prepare_for_maximize() -> void:
	old_unmaximized_position = global_position
	old_unmaximized_size = size

func restore_window() -> void:
	is_maximized = false
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", old_unmaximized_position, 0.25)
	# Using await here ensures the size change happens after the position animation completes
	await tween.tween_property(self, "size", old_unmaximized_size, 0.25).finished

func animate_maximize() -> void:
	is_maximized = true
	var new_size: Vector2 = get_viewport().get_visible_rect().size / 3
	new_size.y -= 22  # Adjust for any window decoration height
	var new_position: Vector2 = Vector2(0, 66)  # Fixed position

	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, 0.25)
	await tween.tween_property(self, "size", new_size, 0.25).finished
