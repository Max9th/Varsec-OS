@icon("res://resources/sprites/easteregg_icon.png")
extends Control
#these are variables:
@onready var person_theme: AudioStreamPlayer = $gaytheme
var person_theme_play: bool = false

signal Disablebk

func _process(delta: float) -> void:
	if not person_theme.playing and person_theme_play == true:
		person_theme.play()
	elif person_theme.playing and person_theme_play == false:
		person_theme.stop()

func start_easter():
	person_theme_play = true
	if person_theme_play:
		Disablebk.emit()

func _on_authenticated_max9th() -> void:
	start_easter()

func _on_mainmenu_stop() -> void:
	person_theme_play = false
	person_theme.stop()
