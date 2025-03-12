class_name splash_screen_vos
extends CanvasLayer

@onready var panel: Panel = $Panel

@export var interpolation_speed: float = 3.0
@export var blank_screen_start: bool
@export var timers: Array[Timer] = []
@export var screens: Array[Node] = []
@export var path_to_scene_target: String

var times_switched: int = 0
var last_switch_time: int = 0
var fading_out: bool = false

func _ready() -> void:
	change_panel_colors(Color.BLACK)
	#audioplayer.play()
	Corec.play_secondary_track("uid://wrlc801ukxib")
	hide_all_screens()
	Corec.is_in_splash = true
	for timer in timers:
		timer.connect("timeout", switch_screen)
		timer.one_shot = true
	timers[0].autostart = true
	timers[0].start()
	if blank_screen_start:
		screens[0].hide()
		times_switched = -1
	else:
		screens[0].show()
		screens[0].modulate.a = 1.0
		times_switched = 0

func hide_all_screens():
	for screen in screens:
		screen.hide()

func switch_screen():
	times_switched += 1
	if times_switched < timers.size():
		timers[times_switched].start()
		fading_out = true
		last_switch_time = Time.get_ticks_msec()
	else:
		change_scene()
	if times_switched +1 == screens.size():
		fade_out_sfx()

func lerp_transition(screen: Node, target_alpha: float) -> void:
	var delta_time = (Time.get_ticks_msec() - last_switch_time) / 1000.0
	screen.modulate.a = lerp(screen.modulate.a, target_alpha, interpolation_speed * delta_time)

func change_scene():
	if path_to_scene_target != "":
		Corec.is_in_splash = false
		get_tree().change_scene_to_file(path_to_scene_target)

func _on_skip_button_pressed() -> void:
	change_scene()

func _process(delta: float) -> void:
	if times_switched >= 0 and times_switched < timers.size():
		if fading_out:
			lerp_transition(screens[times_switched - 1], 0.0)
			if abs(screens[times_switched - 1].modulate.a - 0.0) < 0.05:
				fading_out = false
				hide_all_screens()
				screens[times_switched].show()
				screens[times_switched].modulate.a = 0.0
		if !fading_out:
			lerp_transition(screens[times_switched], 1.0)

func change_panel_colors(color: Color):
	var existing_stylebox = panel.get_theme_stylebox("panel")
	if existing_stylebox:
		var new_stylebox = existing_stylebox.duplicate()
		new_stylebox.bg_color = color
		panel.add_theme_stylebox_override("panel", new_stylebox)


func _on_timer_timeout() -> void:
	change_panel_colors(Color("10141f"))

var bus_name = "sfx_1"
var fade_duration = 9.0
var target_volume = -80.0

func fade_out_sfx():
	var current_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name))
	var tween = create_tween()
	tween.tween_method(Callable(self, "_set_bus_volume"), current_volume, target_volume, fade_duration)

func _set_bus_volume(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), volume)
