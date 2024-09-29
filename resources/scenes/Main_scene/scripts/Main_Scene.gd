extends Control


@onready var ambientsound: AudioStreamPlayer = $ambientsound
@onready var takecare: AudioStreamPlayer = $desktop/Folders/rightvboxcon/musicplayer/takecare

@onready var splash_screen: CanvasLayer = $splash_screen
@onready var background: Panel = $desktop/background

@onready var selectom: Sprite2D = $theonewhowaits

@onready var time: Label = $desktop/panel/Panel/time
@onready var date: Label = $desktop/panel/Panel/date

@onready var sfx_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/sfx_button_sprite

@onready var vfx: ColorRect = $vfx
@onready var vfx_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/vfx_button_sprite

@onready var windows: Control = $desktop/windows
@onready var personalworkswindow: Panel = $desktop/windows/personalworkswindow
@onready var class_manager_window: Panel = $desktop/windows/class_manager_window

@onready var easter_button: Button = $desktop/panel/Panel/easter_button
@onready var easter_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/easter_button_sprite

var playaudio: bool = true
var easter: bool

signal stop

func _on_power_button_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	vfx.visible = true
	vfx_button_sprite.texture = load("res://resources/sprites/vfx.png")
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	easter_button_sprite.visible = false
	easter_button.disabled = true
	windows.visible = true
	update_time()

func _process(_delta: float) -> void:
	if splash_screen.visible == false and ambientsound.playing == false and background.visible == true and playaudio == true:
		ambientsound.playing = true
		sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	elif ambientsound.playing == true and playaudio == false:
		sfx_button_sprite.texture = load("res://resources/sprites/disabledsfx.png")
		ambientsound.playing = false

func _on_sfx_button_pressed() -> void:
	playaudio = !playaudio

func _on_cubigor_cubigorbk() -> void:
	background.visible = false
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	selectom.visible = false
	takecare.playing = false
	easter_time()

func _on_gaytscn_disablebk() -> void:
	background.visible = false
	takecare.playing = false
	easter_time()

func _on_vfx_button_pressed() -> void:
	vfx.visible = !vfx.visible
	if vfx.visible == false:
		vfx_button_sprite.texture = load("res://resources/sprites/disabledvfx.png")
	else:
		vfx_button_sprite.texture = load("res://resources/sprites/vfx.png")

func easter_time():
	easter = !easter
	if easter:
		easter_button.disabled = false
		easter_button_sprite.visible = true
	else:
		easter_button.disabled = true
		easter_button_sprite.visible = false

func _on_easter_button_pressed() -> void:
	background.visible = true
	stop.emit()
	easter_time()

func update_time() -> void:
	var date_dict: Dictionary = Time.get_datetime_dict_from_system()
	time.text = "%02d:%02d" % [date_dict.hour, date_dict.minute]
	date.text = "%02d/%02d/%d" % [date_dict.day, date_dict.month, date_dict.year]

func _on_timer_timeout() -> void:
	update_time()
