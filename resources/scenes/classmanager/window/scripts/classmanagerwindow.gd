extends Panel

@onready var maximize: Button = $HBoxContainer/maximize
@onready var close_audio: AudioStreamPlayer = $close_audio

@export var visiblewindow:bool

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

var is_maximized: bool
var old_unmaximized_position: Vector2
var old_unmaximized_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if visiblewindow == false:
		visible = false
	else:
		visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_dragging:
		global_position = Windowz.handle_dragging(start_drag_position, mouse_start_drag_position, get_global_mouse_position())

func _on_close_pressed() -> void:
	visible = false
	close_audio.play()

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and is_maximized == false:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false

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
		
		var new_size: Vector2 = get_viewport_rect().size / 3
		new_size.y -= 22
		var new_position: Vector2
		new_position.x = 0
		new_position.y = 66
	
		var tween: Tween = create_tween()
		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_position", new_position, 0.25)
		await tween.tween_property(self, "size", new_size, 0.25).finished


func _on_aulas_window_selected() -> void:
	visible = true
