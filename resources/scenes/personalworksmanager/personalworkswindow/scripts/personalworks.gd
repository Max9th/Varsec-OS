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

@export var visiblewindow: bool 


func _ready() -> void:
	if visiblewindow == false:
		aula_select.visible = false
	else:
		aula_select.visible = true
func _process(_delta: float) -> void:
	if is_dragging:
		global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
		clamp_window_inside_viewport()

func _on_close_pressed() -> void:
	aula_select.visible = false
	close_audio.play()

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and is_maximized == false:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false

func clamp_window_inside_viewport() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var position2 = global_position
	var object_size = size * 2.78
	
	position.x = clamp(position2.x, 0, viewport_size.x - object_size.x)
	position.y = clamp(position2.y, 0, viewport_size.y - object_size.y)
	global_position = position2

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
		
		var new_size: Vector2 = get_viewport().get_visible_rect().size / 2
		new_size.y -= 11  # Adjust for any window decoration height
		var new_position: Vector2 = Vector2(0, 66)  # Fixed position
	
		var tween: Tween = create_tween()
		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", new_position, 0.25)
		await tween.tween_property(self, "size", new_size, 0.25).finished


func _on_aulas_window_selected() -> void:
	aula_select.visible = true
