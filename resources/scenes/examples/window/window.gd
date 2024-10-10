class_name Windowz extends Panel

@onready var close_audio: AudioStreamPlayer = $close_audio

var is_dragging: bool = false
var is_maximized: bool = false
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2
var old_unmaximized_position: Vector2
var old_unmaximized_size: Vector2

var game_window_size: Vector2 = get_viewport_rect().size

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if is_dragging:
		global_position = handle_dragging(start_drag_position, mouse_start_drag_position, get_global_mouse_position())

func _on_close_pressed() -> void:
	close_window()

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			start_dragging()
		else:
			stop_dragging()

static func handle_dragging(start_drag_position: Vector2, mouse_start_drag_position: Vector2, current_mouse_position: Vector2) -> Vector2:
	return start_drag_position + (current_mouse_position - mouse_start_drag_position)

func start_dragging() -> void:
	is_dragging = true
	start_drag_position = global_position
	mouse_start_drag_position = get_global_mouse_position()

func stop_dragging() -> void:
	is_dragging = false

func close_window() -> void:
	visible = false
	close_audio.play()

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
	await tween.tween_property(self, "size", old_unmaximized_size, 0.25).finished

func animate_maximize() -> void:
	is_maximized = true
	var new_size: Vector2 = get_viewport().get_visible_rect().size / 3
	new_size.y -= 22
	var new_position: Vector2 = Vector2(0, 66)

	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, 0.25)
	await tween.tween_property(self, "size", new_size, 0.25).finished
