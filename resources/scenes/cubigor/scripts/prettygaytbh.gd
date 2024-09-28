extends Node2D
#these are variables:
@onready var person_theme: AudioStreamPlayer = $gaytheme
var person_mode: bool = false

signal Disablebk

func _process(_delta: float) -> void:
	person_spawner()

func person_spawner():  
	if person_mode:
		if not person_theme.playing:  
			person_theme.play() 
			Disablebk.emit()
	else:
		if person_theme.playing:
			person_theme.stop()


func _on_authenticated_max9th() -> void:
		person_mode = true

func _on_mainmenu_stop() -> void:
	person_mode = false
