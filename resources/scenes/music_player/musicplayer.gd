extends Control

@onready var selected_panel: Panel = $selected_panel
@onready var timer: Timer = $Timer
@onready var filename: Label = $filename
@onready var takecare: AudioStreamPlayer = $takecare
@onready var folder: TextureButton = $"."
@onready var select_audio: AudioStreamPlayer = $select_audio

var selected: bool = false
var timer_running: bool = false
var playing = false

func _ready() -> void:
	filename.label_settings.font_color = Color(1,1,1) # Set label text to white
	selected_panel.visible = false
func _process(_delta: float) -> void:
	timer_running = not timer.is_stopped()
	if playing:
		folder.texture_normal = load("res://sprites/audiodisabled.png")
		folder.texture_hover = load("res://sprites/audiodisabled.png")
		folder.texture_pressed = load("res://sprites/audiodisabled.png")
		filename.text = "Stop playing"
	else:
		folder.texture_normal = load("res://sprites/audio.png")
		folder.texture_hover = load("res://sprites/audio.png")
		folder.texture_pressed = load("res://sprites/audio.png")
		filename.text = "play take care"
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

func spawnwindow():
		playin()

func playin():
	playing = !playing
	if playing:
		takecare.play()
	else:
		takecare.stop()
