extends Control

@onready var timer: Timer = $doubleclicktimer
@onready var filename: Label = $filename
@onready var nelixwindow: Panel = $"../../../windows/nelixwindow"
@onready var selected_panel: Panel = $selected_panel
@onready var select_audio: AudioStreamPlayer = $select_audio

var selected: bool = false
var timer_running: bool = false
var is_mouse_hover

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
			select_audio.play()
		else:
			filename.label_settings.font_color = Color(1,1,1) # Set label text to white
			selected_panel.visible = false
	elif selected and timer_running:
		spawnwindow()

func _on_pressed() -> void:
	select()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and is_mouse_hover == false:
		filename.label_settings.font_color = Color(1,1,1) # Set label text to white
		selected_panel.visible = false

func spawnwindow():
	#get_tree().change_scene_to_file("res://scenes/nelix_game/components/levels/proto1.tscn")
	nelixwindow.visible = true

func _on_mouse_entered() -> void:
	is_mouse_hover = true

func _on_mouse_exited() -> void:
	is_mouse_hover = false
