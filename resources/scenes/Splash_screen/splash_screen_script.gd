class_name splash_screen_vos
extends CanvasLayer

@export var blank_screen_start: bool
@export var timers: Array[Timer] = []
@export var screens: Array[Node] = []
@export var path_to_scene_target: String


var times_switched: int = 0

func _ready() -> void:
	hide_all_screens()
	Corec.is_in_splash = true
	for timer in timers:
		timer.connect("timeout", switch_screen)
		timer.one_shot = true
	timers[0].autostart = true
	timers[0].start()
	if !blank_screen_start:
		screens[0].show()
	else:
		times_switched -= 1

func hide_all_screens():
	for screen in screens:
		screen.hide()

func switch_screen():
	times_switched +=1 #if times_switched < timers.size() - 1 else 0
	if times_switched < timers.size():
		timers[times_switched].start()
		hide_all_screens()
		screens[times_switched].show()
	else:
		change_scene()

func change_scene():
	if path_to_scene_target != "":
		Corec.is_in_splash = false
		get_tree().change_scene_to_file(path_to_scene_target)
	else:
		print("Error: Empty scene path")

func _on_skip_button_pressed() -> void:
	change_scene()
