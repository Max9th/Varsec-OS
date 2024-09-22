extends Panel

@onready var incorrect: Label = $INCORRECT
@onready var text_edit: TextEdit = $TextEdit
@onready var timer: Timer = $Timer
@onready var authenticate_popup: Panel = $"."


var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

func _ready() -> void:
	authenticate_popup.visible = false
func _process(delta: float) -> void:
	if is_dragging:
		global_position = start_drag_position + (get_global_mouse_position() - mouse_start_drag_position)
		clamp_window_inside_viewport()
func _on_close_pressed() -> void:
	authenticate_popup.visible = false

func _on_timer_timeout() -> void:
	incorrect.visible = false

func _on_confirm_pressed() -> void:
	if text_edit.text == "cubigor":
		authenticate_popup.visible = false
		get_tree().call_group("authentication","_on_authenticate_popup_authenticated")
	if text_edit.text == "max9th":
		authenticate_popup.visible = false
		get_tree().call_group("authentication","_on_authenticated")
	elif text_edit.text != "cubigor" and text_edit.text != "max9th":
		incorrect.visible = true
		timer.start()
		text_edit.text = ""


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
	
