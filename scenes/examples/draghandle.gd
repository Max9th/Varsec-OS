extends Panel

@onready var window: Panel = $".."

signal window_resized()

var start_size: Vector2
var is_dragging: bool
var mouse_start_drag_position: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window = get_parent()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			is_dragging = true
			mouse_start_drag_position = get_global_mouse_position()
			start_size = get_parent().size
		else:
			is_dragging = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_dragging:
		# TODO optimize this a bit?
		if Input.is_key_pressed(KEY_SHIFT):
			var aspect_ratio: float = start_size.x / (start_size.y - 30)
			window.size.x = start_size.x + (get_global_mouse_position().x - mouse_start_drag_position.x) * aspect_ratio
			window.size.y = start_size.y + get_global_mouse_position().x - mouse_start_drag_position.x
			window_resized.emit()
		else:
			window.size = start_size + get_global_mouse_position() - mouse_start_drag_position
		window.clamp_window_inside_viewport()
