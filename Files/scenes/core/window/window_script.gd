@tool
@icon("uid://cx0s8jijvshei")
class_name window_vos extends NinePatchRect

@export_category("Necessary children")

@export var window_name_label: Label

@export var drag_handle: Control:
	set = set_drag_handle

@export var resize_handle: Control:
	set = set_resize_handle

@export var maximize: Button:
	set = set_maximize_button

@export var close: Button:
	set = set_close_button

@export var audioplayer: AudioStreamPlayer

@export_category("Window properties")
@export var can_drag: bool
@export var can_maximize: bool
@export var can_close: bool
@export var can_resize: bool
@export var is_instance_type: bool
@export var has_max_size: bool
@export var max_size: Vector2

@onready var viewport_size = get_viewport().get_visible_rect().size

signal closed

func _init() -> void:
	self.custom_minimum_size = Vector2(258, 144)
	self.texture = load("uid://u37075llycfy")
	self.region_rect = Rect2(0,0, 150, 150)
	self.patch_margin_left = 12
	self.patch_margin_top = 33
	self.patch_margin_right = 61
	self.patch_margin_bottom = 25
	self.connect("gui_input", _on_gui_input)
	#Corec.opened_programs.append(self)
	if self not in Corec.opened_programs:
		Corec.opened_programs.append(self)

func set_drag_handle(value):
	if value:
		value.gui_input.connect(_on_drag_handle_gui_input)
		drag_handle = value
	else:
		print("Drag handle was not defined for window " + name)

func set_resize_handle(value):
	if value:
		value.gui_input.connect(_on_resize_handle_gui_input)
		resize_handle = value
	else:
		print("Resize handle was not defined for window " + name)
	#return value

func set_maximize_button(value):
	if value:
		value.pressed.connect(_on_maximize_pressed)
		maximize = value
	else:
		print("Maximize button was not defined for window " + name)
	#return value

func set_close_button(value):
	if value:
		value.pressed.connect(_on_close_pressed)
		close = value
	else:
		print("Close button was not defined for window " + name)
	#return value

#region Logic for maximizing and closing

var panel_height: int = Corec.panel_height #shared with drag logic
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
func maximize_window(target: window_vos) -> void:
	var tween: Tween = target.create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var new_size: Vector2 = target.get_viewport().get_visible_rect().size
	new_size.y -= panel_height
	var new_position: Vector2 = Vector2(0, panel_height)
	tween.tween_property(target, "global_position", new_position, animation_velocity)
	await tween.tween_property(target, "size", new_size, animation_velocity).finished

func restore_window(target: window_vos, unmaxed_position: Vector2, unmaxed_size: Vector2) -> void:
	var tween: Tween = target.create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(target, "global_position", unmaxed_position, animation_velocity)
	await tween.tween_property(target, "size", unmaxed_size, animation_velocity).finished
#endregion

func close_window():
	Corec.opened_programs.erase(self)
	audioplayer.play()
	await audioplayer.finished
	if can_close:
		if is_instance_type:
			closed.emit()
			self.queue_free()
		else:
			self.visible = false
	else:
		print("Closing this window is not possible " + name)


#endregion

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		select()

func select():
	get_parent().move_child(self, Corec.opened_programs.size())

func deselect():
	pass

#region Drag logic (reusable)

var is_dragging: bool
var mouse_start_drag_position: Vector2 # shared with resize logic
var start_drag_position: Vector2

#var panel_height: int = 80 shared with drag logic

func _on_drag_handle_gui_input(event: InputEvent) -> void:
	detect_start_dragging(event)
	drag_process()

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
	#drag_handle.size.x = self.size.x - 60
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
	resize_process()

func handle_aspect_ratio_resize(window: window_vos, mouse_pos: Vector2, starting_size: Vector2, mouse_start_drag_pos: Vector2) -> void:
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
