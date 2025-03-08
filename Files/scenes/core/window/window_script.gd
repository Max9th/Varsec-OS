@icon("res://resources/sprites/window_icon.png")
class_name window_vos extends Panel

@export_category("Necessary children:")
@export var window_name_label: Label
@export var audioplayer: AudioStreamPlayer
@export var drag_handle: Control
@export var resize_handle: Control
@export var maximize: Button
@export var close: Button

@export_category("Window properties")
@export var show_window: bool
@export var can_drag: bool
@export var can_maximize: bool
@export var can_close: bool
@export var can_resize: bool
@export var is_instance_type: bool
@export var has_max_size: bool
@export var max_size: Vector2

@onready var viewport_size = get_viewport().get_visible_rect().size

signal closed

func _ready() -> void:
#region Conects signals
	drag_handle.gui_input.connect(_on_drag_handle_gui_input)
	resize_handle.gui_input.connect(_on_resize_handle_gui_input)
	maximize.pressed.connect(_on_maximize_pressed)
	close.pressed.connect(_on_close_pressed)
#endregion
	if show_window == true:
		self.show()
	else:
		self.hide()
	#debugready()

func _process(_delta: float) -> void:
	drag_process()
	resize_process()

	#debugproc()

##region Debug
#func debugready():
	#if OS.is_debug_build():
		#maximize.self_modulate.a = 1
		#close.self_modulate.a = 1
		#$Drag_handle/Panel.visible = true
		#$Resize_handle/Panel.visible = true
	#else:
		#maximize.self_modulate.a = 0
		#close.self_modulate.a = 0
		#$Drag_handle/Panel.visible = false
		#$Resize_handle/Panel.visible = false
#
#func debugproc():
	#if OS.is_debug_build():
		#$Drag_handle/Panel.size.x = drag_handle.size.x
		#$Drag_handle/Panel.global_position.x = drag_handle.global_position.x
##endregion

#region Logic for maximizing and closing

var panel_height: int = 80 #shared with drag logic
var animation_velocity: float = 0.25 # Bigger is slower
var is_maximized: bool
var unmaximized_position: Vector2
var unmaximized_size: Vector2

func _on_close_pressed() -> void:
	close_window()

func _on_maximize_pressed() -> void:
	if can_maximize:
		if is_maximized:
			restore_window(self, unmaximized_position, unmaximized_size)
		else:
			unmaximized_position = global_position
			unmaximized_size = size
			maximize_window(self)
		is_maximized = !is_maximized

#region I don't fucking know what is going on inside these two functions, but they work perfectly, so, that's great O_O
func maximize_window(target: Panel) -> void:
	var tween: Tween = target.create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var new_size: Vector2 = target.get_viewport().get_visible_rect().size
	new_size.y -= panel_height
	var new_position: Vector2 = Vector2(0, panel_height)
	tween.tween_property(target, "global_position", new_position, animation_velocity)
	await tween.tween_property(target, "size", new_size, animation_velocity).finished

func restore_window(target: Panel, unmaxed_position: Vector2, unmaxed_size: Vector2) -> void:
	var tween: Tween = target.create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(target, "global_position", unmaxed_position, animation_velocity)
	await tween.tween_property(target, "size", unmaxed_size, animation_velocity).finished
#endregion

func close_window():
	audioplayer.play()
	await audioplayer.finished
	if can_close:
		if is_instance_type:
			closed.emit()
			self.queue_free()
		else:
			self.visible = false


#endregion

#region Drag logic (reusable)

var is_dragging: bool
var mouse_start_drag_position: Vector2 # shared with resize logic
var start_drag_position: Vector2

#var panel_height: int = 80 shared with drag logic

func _on_drag_handle_gui_input(event: InputEvent) -> void:
	detect_start_dragging(event)

func detect_start_dragging(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			print("Started dragging!")
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false


func drag_process() -> void:
	drag_handle.size.x = self.size.x - 60
	if is_dragging and can_drag:
		global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
		global_position.x = clamp(global_position.x, 0, viewport_size.x - self.size.x)
		global_position.y = clamp(global_position.y, panel_height, viewport_size.y - self.size.y)


#endregion


#region Resize logic (reusable)

var is_resizing: bool
# var mouse_start_drag_position: Vector2 # shared with drag logic. Was already defined
var start_size: Vector2

func detect_start_resizing(event: InputEvent) -> void:
	if can_resize:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_resizing = true
				mouse_start_drag_position = get_global_mouse_position()
				start_size = self.size
				print("Started resizing!")
			else:
				is_resizing = false

func _on_resize_handle_gui_input(event: InputEvent) -> void:
	detect_start_resizing(event)

func handle_aspect_ratio_resize(window: Panel, mouse_pos: Vector2, starting_size: Vector2, mouse_start_drag_pos: Vector2) -> void:
	var aspect_ratio: float = starting_size.x / starting_size.y
	var new_width = starting_size.x + (mouse_pos.x - mouse_start_drag_pos.x)
	window.size.x = new_width
	window.size.y = (new_width / aspect_ratio)
	print("Aspect ratio resize detected!")

func resize_process() -> void:
	if is_resizing and can_resize:
		var mouse_position = get_global_mouse_position()
		if Input.is_key_pressed(KEY_SHIFT):
			handle_aspect_ratio_resize(self, mouse_position, start_size, mouse_start_drag_position)
		else:
			self.size = start_size + (mouse_position - mouse_start_drag_position) # Used to be an independent function
			self.size.x = min(self.size.x, viewport_size.x - global_position.x)
			self.size.y = min(self.size.y, viewport_size.y - global_position.y)
		if has_max_size:
			self.size.x = clamp(self.size.x, 258, max_size.x)
			self.size.y = clamp(self.size.y, 121, max_size.y)
#endregion
