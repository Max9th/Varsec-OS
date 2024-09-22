extends Panel

@onready var incorrect: Label = $INCORRECT
@onready var text_edit: TextEdit = $TextEdit
@onready var timer: Timer = $Timer
@onready var window: Panel = $"."
@onready var maximize: Button = $maximize
@onready var resizehandle: Panel = $resizehandle

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2
var is_maximized: bool
var old_unmaximized_position: Vector2
var old_unmaximized_size: Vector2

func _ready() -> void:
	window.visible = false

func _process(delta: float) -> void:
	if is_dragging:
		global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
		clamp_window_inside_viewport()
func _on_close_pressed() -> void:
	window.visible = false

func _on_timer_timeout() -> void:
	incorrect.visible = false

func _on_confirm_pressed() -> void:
	pass

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false

func clamp_window_inside_viewport() -> void:
	var game_window_size: Vector2 = get_viewport_rect().size
	if (size.y > game_window_size.y - 40):
		size.y = game_window_size.y - 40
	if (size.x > game_window_size.x):
		size.x = game_window_size.x
	


func _on_maximize_pressed() -> void:
	maximize_window()

	clamp_window_inside_viewport()
func maximize_window() -> void:
	if is_maximized:
		is_maximized = !is_maximized
		
		var tween: Tween = create_tween()
		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", old_unmaximized_position, 0.25)
		await tween.tween_property(self, "size", old_unmaximized_size, 0.25).finished
		
		resizehandle.window_resized.emit()
	else:
		is_maximized = !is_maximized
		
		old_unmaximized_position = global_position
		old_unmaximized_size = size
		
		var new_size: Vector2 
		new_size.x = 384
		new_size.y = 216
	
	
		var tween: Tween = create_tween()
		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", Vector2.ZERO, 0.25)
		await tween.tween_property(self, "size", new_size, 0.25).finished
		resizehandle.window_resized.emit()

func _on_viewport_size_changed() -> void:
	if is_maximized:
		var new_size: Vector2 
		new_size.x = 1152
		new_size.y = 648
		global_position = Vector2.ZERO
		size = new_size
