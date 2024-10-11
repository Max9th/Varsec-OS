class_name Windowz extends Panel

@onready var close_audio: AudioStreamPlayer = $close_audio
@onready var window: Windowz = $"."

@export var is_visible: bool
@export var can_drag: bool
@export var can_maximize: bool
@export var can_close: bool

var is_dragging: bool = false
var is_maximized: bool = false
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2
var old_unmaximized_position: Vector2
var old_unmaximized_size: Vector2

# ---- Static functions that can be used in other scripts ----

# Static dragging handler
static func handle_dragging(start_drag_position: Vector2, mouse_start_drag_position: Vector2, current_mouse_position: Vector2) -> Vector2:
	return start_drag_position + (current_mouse_position - mouse_start_drag_position)

#close window
static func close_window(target: Panel, close_audio: AudioStreamPlayer) -> void:
	target.visible = false
	close_audio.play()

#maximize the window
static func maximize_window(target: Panel, old_unmaximized_position: Vector2, old_unmaximized_size: Vector2) -> void:
	var tween: Tween = target.create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

	#new size and position for maximizing
	var new_size: Vector2 = target.get_viewport().get_visible_rect().size / 3
	new_size.y -= 22
	var new_position: Vector2 = Vector2(0, 66)

	tween.tween_property(target, "global_position", new_position, 0.25)
	await tween.tween_property(target, "size", new_size, 0.25).finished

#restore window
static func restore_window(target: Panel, old_unmaximized_position: Vector2, old_unmaximized_size: Vector2) -> void:
	var tween: Tween = target.create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

	tween.tween_property(target, "global_position", old_unmaximized_position, 0.25)
	await tween.tween_property(target, "size", old_unmaximized_size, 0.25).finished
	
static func clamp_window_inside_viewport(global_pos: Vector2, window_size: Vector2, viewport_size: Vector2, scale_factor) -> Vector2:
	var position2 = global_pos
	var object_size = window_size * scale_factor  # Adjust the scale factor if necessary

	# Clamp the X and Y coordinates to ensure the window stays inside the viewport
	position2.x = clamp(position2.x, 0, viewport_size.x - object_size.x)
	position2.y = clamp(position2.y, 0, viewport_size.y - object_size.y)

	# Return the new clamped position
	return position2


# ---- Non-static instance-specific functions ----

func _ready() -> void:
	if is_visible:
		self.show()
	else:
		self.hide()

func _process(_delta: float) -> void:
	if is_dragging and can_drag:
		global_position = handle_dragging(start_drag_position, mouse_start_drag_position, get_global_mouse_position())
		global_position = Windowz.clamp_window_inside_viewport(global_position, size, get_viewport().get_visible_rect().size, 3)

func _on_close_pressed() -> void:
	close_window(window, close_audio)

func _on_maximize_pressed() -> void:
	if can_maximize:
		if is_maximized:
			restore_window(self, old_unmaximized_position, old_unmaximized_size)
		else:
			old_unmaximized_position = global_position
			old_unmaximized_size = size
			maximize_window(self, old_unmaximized_position, old_unmaximized_size)
		is_maximized = !is_maximized


func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false
