extends Control

@onready var vfx: ColorRect = $vfx
@onready var ambientsound: AudioStreamPlayer = $ambientsound
@onready var splash_screen: CanvasLayer = $splash_screen
@onready var background: Panel = $desktop/background
@onready var selectom: Sprite2D = $easteregg2
@onready var time: Label = $desktop/panel/Panel2/time
@onready var date: Label = $desktop/panel/Panel2/time/date
@onready var takecare: AudioStreamPlayer = $desktop/Folders/rightvboxcon/musicplayer/takecare
@onready var sfx_button_sprite: TextureRect = $desktop/panel/Panel2/HBoxContainer/sfx_button_sprite
@onready var vfx_button_sprite: TextureRect = $desktop/panel/Panel2/HBoxContainer/vfx_button_sprite
@onready var windows: Control = $desktop/windows
@onready var easter_button_sprite: TextureRect = $desktop/panel/Panel2/HBoxContainer/easter_button_sprite
@onready var easter_button: Button = $desktop/panel/Panel2/easter_button

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
func _process(_delta: float) -> void:
	if splash_screen.visible == false and ambientsound.playing == false and background.visible == true and playaudio == true:
		ambientsound.playing = true
		sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	elif ambientsound.playing == true and playaudio == false:
		sfx_button_sprite.texture = load("res://resources/sprites/disabledsfx.png")
		ambientsound.playing = false
	var timefunc = Time.get_time_dict_from_system()
	var datefunc = Time.get_date_string_from_system()
	
	time.text = str("%02d:%02d:%02d" % [timefunc.hour, timefunc.minute, timefunc.second])
	date.text = datefunc

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
	
