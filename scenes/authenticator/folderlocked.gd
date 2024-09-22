extends Control

@onready var selected_panel: Panel = $selected
@onready var timer: Timer = $Timer
@onready var filename: Label = $filename
@onready var authenticate_popup: Panel = $authenticate_popup

var selected: bool = false
var timer_running: bool = false

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

func _ready() -> void:
	filename.label_settings.font_color = Color(1,1,1) # Set label text to white
	selected_panel.visible = false
func _process(_delta: float) -> void:
	timer_running = not timer.is_stopped()
func select():
	if !timer_running:
		selected = !selected
		if selected:
			selected_panel.visible = true
			filename.label_settings.font_color = Color(0,0,0) # Set label text to black
			timer.start() # Start the timer
		else:
			filename.label_settings.font_color = Color(1,1,1) # Set label text to white
			selected_panel.visible = false
	elif selected and timer_running:
		spawnwindow()

func _on_pressed() -> void:
	select()

func spawnwindow():
		authenticate_popup.visible = true
	

	
