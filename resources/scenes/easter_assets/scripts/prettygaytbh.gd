@icon("res://resources/sprites/easteregg_icon.png")
extends Control

@onready var sfx: AudioStreamPlayer = $sfx
var sfx_play: bool = false

func _process(delta: float) -> void:
	if not sfx.playing and sfx_play == true:
		sfx.play()
	elif sfx.playing and sfx_play == false:
		sfx.stop()

func _on_authenticated_max9th() -> void:
	sfx_play = true
	get_tree().call_group("main_scene", "easter_state_manager", "gax", true)

func _on_mainmenu_stop() -> void:
	sfx_play = false
	sfx.stop()
