extends CanvasLayer

@onready var sfx = $sfx
@onready var ui = $"."
@onready var fps_label = $Debug/fps_label
@onready var options = $PauseMenu/Options
@onready var main_pause = $PauseMenu/Main
@onready var cursor = $Cursor

var paused = false
var settings = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause()
	fps_label.text = ("FPS %d" % Engine.get_frames_per_second())

func _on_play_pressed():
	pause()

func _on_quit_pressed():
	get_tree().quit()

func pause(): 
	paused = !paused
	if paused:
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		main_pause.visible = true
		cursor.visible = false
		sfx.play()
	else:
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		main_pause.visible = false
		options.visible = false
		settings = false
		cursor.visible = true
		sfx.play()


func _on_options_pressed():
	setts_menu()

func _on_back_pressed():
	setts_menu()

func setts_menu():
	settings = !settings
	if settings:
		options.visible = true
		main_pause.visible = false
	else:
		options.visible = false
		main_pause.visible = true
