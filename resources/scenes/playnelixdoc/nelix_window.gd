@icon("res://resources/sprites/window_icon.png")
extends Panel

@onready var close_audio: AudioStreamPlayer = $close_audio

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

var is_maximized: bool
var unmaximized_position: Vector2
var old_unmaximized_size: Vector2

@export_category("Window properties")
@export var is_visible: bool
@export var can_drag: bool
@export var can_maximize: bool
@export var can_close: bool
@export var can_resize: bool
@export var is_instance_type: bool


func _ready() -> void:
	if is_visible:
		self.show()
	else:
		self.hide()

func _process(_delta: float) -> void:
	if is_dragging and can_drag:
		global_position = Windowz.handle_dragging(start_drag_position, mouse_start_drag_position, get_global_mouse_position())
		global_position = Windowz.clamp_window_inside_viewport(global_position, size, get_viewport().get_visible_rect().size, 3)

func _on_close_pressed() -> void:
	if is_instance_type:
		queue_free()
	else:
		Windowz.close_window(self, close_audio)

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and is_maximized == false:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false


func _on_maximize_pressed() -> void:
	if can_maximize:
		is_maximized = !is_maximized
		if is_maximized:
			Windowz.restore_window(self, unmaximized_position, old_unmaximized_size)
		else:
			unmaximized_position = global_position
			old_unmaximized_size = size
			Windowz.maximize_window(self, unmaximized_position, old_unmaximized_size)
