@icon("uid://4hlbl2jngrh7")
extends Control

@onready var background_panel: Panel = $BackgroundPanel
@onready var click_to_start_label := $Content/CenterContainer/VBoxContainer

@export var interpolation_duration: float = 3.0
@export var blank_screen_start: bool
@export var timers: Array[Timer] = []
@export var screens: Array[Control] = []



var has_splash_started: bool = false
var times_switched: int = 0
var total_screens: int

var target_scene_uid: String

signal interpolation_complete

func _ready() -> void:
	$Content/Screens.show()
	target_scene_uid = Core.desktop_uid
	total_screens = screens.size()
	Core.is_in_splash = true
	if screens.is_empty():
		print("Error: No screens to display (SplashScreen_vos)!")
	else:
		change_background_panel_color(Color.BLACK)
		for screen in screens:
			screen.hide()
	for screen in screens:
		screen.modulate.a = 0.0
		screen.hide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and has_splash_started == false:
		has_splash_started = true
		if click_to_start_label:
			click_to_start_label.queue_free()
		var tween = create_tween()
		await tween.tween_method(Callable(self, "change_background_panel_color"), Color.BLACK, Color("10141f"), .1).finished
		start_splashscreen()
		Core.play_secondary_track("uid://wrlc801ukxib")

func start_splashscreen() -> void:
	print("A")
	for timer in timers:
		timer.connect("timeout", switch_screen)
		timer.one_shot = true
	timers[0].autostart = true
	timers[0].start()
	if blank_screen_start:
		screens[0].hide()
		times_switched = -1
	else:
		transition_screen(screens[0], true)
		await interpolation_complete

func switch_screen() -> void:
	times_switched += 1
	var previous_screen = screens[times_switched - 1]
	var current_screen = screens[times_switched if times_switched < total_screens else total_screens - 1]
	var next_screen = screens[times_switched + 1 if times_switched < total_screens - 1 else total_screens - 1]
	if times_switched < total_screens:
		transition_screen(previous_screen, false)
		await interpolation_complete
		transition_screen(current_screen, true)
		await interpolation_complete
		timers[times_switched].start()
	else:
		transition_screen(current_screen, false)
		await interpolation_complete
		change_scene()
	if times_switched +1 >= screens.size():
		Core.fade_out_secondary_sfx("sfx_1", -80, 9)

func transition_screen(target: Control, fade_in: bool = true) -> void:
	var tween: Tween = target.create_tween()
	#tween.set_parallel(true)
	if fade_in:
		target.show()
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		await tween.tween_property(target, "modulate:a", 1.0, interpolation_duration).finished
		await get_tree().create_timer(1.0).timeout
	else:
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
		await tween.tween_property(target, "modulate:a", 0.0, interpolation_duration).finished
		target.hide()
	interpolation_complete.emit()

func _on_skip_button_pressed() -> void:
	change_scene()

func change_scene():
	if !target_scene_uid.is_empty():
		Core.is_in_splash = false
		get_tree().change_scene_to_file(target_scene_uid)
	else:
		print("Error: No target scene UID specified!")

func change_background_panel_color(color: Color) -> void:
	var existing_stylebox = background_panel.get_theme_stylebox("panel")
	if existing_stylebox:
		var new_stylebox = existing_stylebox.duplicate()
		new_stylebox.bg_color = color
		background_panel.add_theme_stylebox_override("panel", new_stylebox)
