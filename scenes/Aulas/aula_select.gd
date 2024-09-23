extends Panel

@onready var aula_select: Panel = $"."
@onready var maximize: Button = $HBoxContainer/maximize
@onready var close_audio: AudioStreamPlayer = $close_audio

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

var is_maximized: bool
var old_unmaximized_position: Vector2
var old_unmaximized_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aula_select.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging:
		global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
		clamp_window_inside_viewport()

func _on_close_pressed() -> void:
	aula_select.visible = false
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
	var position = global_position
	var object_size = size * 2.78
	
	position.x = clamp(position.x, 0, viewport_size.x - object_size.x)
	position.y = clamp(position.y, 0, viewport_size.y - object_size.y)
	global_position = position

func _on_maximize_pressed() -> void:
	maximize_window()

func maximize_window() -> void:
	if is_maximized:
		is_maximized = !is_maximized
		var tween: Tween = create_tween()
		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", old_unmaximized_position, 0.25)
		await tween.tween_property(self, "size", old_unmaximized_size, 0.25).finished
	else:
		is_maximized = !is_maximized
		old_unmaximized_position = global_position
		old_unmaximized_size = size
		
		var new_size: Vector2 
		var new_position: Vector2
		new_position.x = 2
	
		new_position.y = 59
		new_size.x = 412
		
		
		new_size.y = 193
	
		var tween: Tween = create_tween()
		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", new_position, 0.25)
		await tween.tween_property(self, "size", new_size, 0.25).finished
