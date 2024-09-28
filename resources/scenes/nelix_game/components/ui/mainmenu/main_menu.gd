extends Control

var settings_visible = false
@onready var main = $Main
@onready var settings = $Settings





func _on_play_pressed():
	get_tree().change_scene_to_file("res://resources/scenes/nelix_game/components/levels/proto1.tscn")

func _on_options_pressed():
	settings_enabled()

func _on_configstittle_pressed():
	settings_enabled()

func _on_back_pressed():
	settings_enabled()

func _on_quit_pressed():
	get_tree().quit()

func settings_enabled():
	settings_visible = !settings_visible
	if settings_visible:
		main.visible = false
		settings.visible = true
	else:
		main.visible = true
		settings.visible = false
