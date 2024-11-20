@icon("res://resources/sprites/window_icon.png")
class_name Windowz extends Panel

@onready var close_audio: AudioStreamPlayer = $close_audio
@onready var window: Windowz = $"."
@onready var windowname: Label = $windowname

@export_category("Window properties")
@export var window_name: String
@export var is_visible: bool
@export var can_drag: bool
@export var can_maximize: bool
@export var can_close: bool
@export var can_resize: bool
@export var is_instance_type: bool

var is_dragging: bool = false
var is_maximized: bool = false
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2
var unmaximized_position: Vector2
var old_unmaximized_size: Vector2

var start_size: Vector2
var is_resizing: bool = false
const SCALE_FACTOR: float = 3
const MAX_WIDTH: float = 384
const MAX_HEIGHT: float = 216

signal closed

# ---- Static functions that can be used in other scripts ----

static func handle_dragging(start_drag_position: Vector2, mouse_start_drag_position: Vector2, current_mouse_position: Vector2) -> Vector2:
	return start_drag_position + (current_mouse_position - mouse_start_drag_position)

static func close_window(target: Panel, close_audio: AudioStreamPlayer) -> void:
	target.visible = false
	close_audio.play()

static func maximize_window(target: Panel, unmaximized_position: Vector2, old_unmaximized_size: Vector2) -> void:
	var tween: Tween = target.create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var new_size: Vector2 = target.get_viewport().get_visible_rect().size / 3
	new_size.y -= 22
	var new_position: Vector2 = Vector2(0, 66)
	tween.tween_property(target, "global_position", new_position, 0.25)
	await tween.tween_property(target, "size", new_size, 0.25).finished

static func restore_window(target: Panel, unmaximized_position: Vector2, old_unmaximized_size: Vector2) -> void:
	var tween: Tween = target.create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(target, "global_position", unmaximized_position, 0.25)
	await tween.tween_property(target, "size", old_unmaximized_size, 0.25).finished

static func clamp_window_inside_viewport(global_pos: Vector2, window_size: Vector2, viewport_size: Vector2, scale_factor) -> Vector2:
	var position2 = global_pos
	var object_size = window_size * scale_factor
	position2.x = clamp(position2.x, 0, viewport_size.x - object_size.x)
	position2.y = clamp(position2.y, 0, viewport_size.y - object_size.y)
	return position2

static func handle_aspect_ratio_resize(window: Panel, mouse_pos: Vector2, start_size: Vector2, mouse_start_drag_position: Vector2, scale_factor: float) -> void:
	var aspect_ratio: float = start_size.x / start_size.y
	var new_width = start_size.x + (mouse_pos.x - mouse_start_drag_position.x)
	window.size.x = new_width / scale_factor
	window.size.y = (new_width / aspect_ratio) / scale_factor

static func handle_free_resize(window: Panel, mouse_pos: Vector2, start_size: Vector2, mouse_start_drag_position: Vector2, scale_factor: float) -> void:
	window.size = start_size + (mouse_pos - mouse_start_drag_position) / scale_factor

# ---- Non-static instance-specific functions ----

func _ready() -> void:
	if is_visible:
		self.show()
	else:
		self.hide()
	windowname.text = window_name

func _process(_delta: float) -> void:
	if is_dragging and can_drag:
		global_position = handle_dragging(start_drag_position, mouse_start_drag_position, get_global_mouse_position())
		global_position = clamp_window_inside_viewport(global_position, size, get_viewport().get_visible_rect().size, SCALE_FACTOR)
	if is_resizing and can_resize:
		var mouse_position = get_global_mouse_position()
		if Input.is_key_pressed(KEY_SHIFT):
			handle_aspect_ratio_resize(window, mouse_position, start_size, mouse_start_drag_position, SCALE_FACTOR)
		else:
			handle_free_resize(window, mouse_position, start_size, mouse_start_drag_position, SCALE_FACTOR)
		if window.size.x > MAX_WIDTH:
			window.size.x = MAX_WIDTH
		if window.size.y > MAX_HEIGHT:
			window.size.y = MAX_HEIGHT

func _on_close_pressed() -> void:
	closed.emit()
	get_tree().call_group("folders", "window_state")
	if is_instance_type:
		queue_free()
	else:
		close_window(window, close_audio)

func _on_maximize_pressed() -> void:
	if can_maximize:
		if is_maximized:
			restore_window(self, unmaximized_position, old_unmaximized_size)
		else:
			unmaximized_position = global_position
			old_unmaximized_size = size
			maximize_window(self, unmaximized_position, old_unmaximized_size)
		is_maximized = !is_maximized

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false

func _on_resizehandle_gui_input(event: InputEvent) -> void:
		if can_resize:
			if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					is_resizing = true
					mouse_start_drag_position = get_global_mouse_position()
					start_size = window.size
				else:
					is_resizing = false
