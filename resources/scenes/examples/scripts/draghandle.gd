extends Control

@onready var window: Windowz = $".."

var start_size: Vector2
var is_resizing: bool = false
var mouse_start_drag_position: Vector2
const SCALE_FACTOR: float = 3
const MAX_WIDTH: float = 384
const MAX_HEIGHT: float = 216

signal resized_window
signal stopped_resizing

func _physics_process(delta: float) -> void:
	if is_resizing:
		var mouse_position = get_global_mouse_position()
		if Input.is_key_pressed(KEY_SHIFT):
			_handle_aspect_ratio_resize(mouse_position)
		else:
			_handle_free_resize(mouse_position)
		if window.size.x > MAX_WIDTH:
			window.size.x = MAX_WIDTH
		if window.size.y > MAX_HEIGHT:
			window.size.y = MAX_HEIGHT

func _handle_aspect_ratio_resize(mouse_pos: Vector2) -> void:
	var aspect_ratio: float = start_size.x / start_size.y
	var new_width = start_size.x + (mouse_pos.x - mouse_start_drag_position.x)
	window.size.x = new_width / SCALE_FACTOR
	window.size.y = (new_width / aspect_ratio) / SCALE_FACTOR

func _handle_free_resize(mouse_pos: Vector2) -> void:
	window.size = start_size + (mouse_pos - mouse_start_drag_position) / SCALE_FACTOR
