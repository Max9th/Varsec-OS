@icon("res://resources/sprites/easteregg_icon.png")
extends Control
#these are variables:
@onready var person_theme: AudioStreamPlayer = $gaytheme
var person_mode: bool = false

signal Disablebk

func _process(delta: float) -> void:
	if not person_theme.playing and person_mode == true:
		person_theme.play()
	elif person_theme.playing and person_mode == false:
		person_theme.stop()

func person_spawner():
	person_mode = true
	if person_mode:
		Disablebk.emit()

func _on_authenticated_max9th() -> void:
	person_spawner()

func _on_mainmenu_stop() -> void:
	person_mode = false
	person_theme.stop()
