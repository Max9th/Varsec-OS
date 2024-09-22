extends Control

@onready var crt: ColorRect = $crt
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var splash_screen: CanvasLayer = $splash_screen
@onready var audio_disabled_texture: TextureRect = $desktop/panel/audio_disabled_texture
@onready var time_label: Label = $desktop/panel/time
@onready var date_label: Label = $desktop/panel/date
@onready var background: Panel = $desktop/background
@onready var takecare: AudioStreamPlayer = $takecare
@onready var selectom: Sprite2D = $gaytscn

var playaudio: bool = true

func _on_power_button_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	crt.visible = true

func _process(_delta: float) -> void:
	if splash_screen.visible == false and audio_stream_player.playing == false and background.visible == true and playaudio == true:
		audio_stream_player.playing = true
		audio_disabled_texture.visible = false
	elif audio_stream_player.playing == true and playaudio == false:
		audio_disabled_texture.visible = true
		audio_stream_player.playing = false
	var time = Time.get_time_dict_from_system()
	var date = Time.get_date_string_from_system()
	time_label.text = str("%02d:%02d:%02d" % [time.hour, time.minute, time.second])
	date_label.text = date

func _on_sound_button_pressed() -> void:
	playaudio = !playaudio

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func _on_cubigor_cubigorbk() -> void: #signal emmited by cubigor after it gets enabled. Disables the background
	background.visible = false
	audio_disabled_texture.visible = false
	selectom.visible = false


func _on_gaytscn_cubigorbk() -> void:
	background.visible = false
	audio_disabled_texture.visible = false
