extends Node2D
@onready var gay_theme: AudioStreamPlayer = $gaytheme
var gay_mode: bool = false
@onready var max: Sprite2D = $Max
signal cubigorbk
func cubigor_spawner():
	if gay_mode:
		if not gay_theme.playing:
			gay_theme.play()
		cubigorbk.emit()
		#background.visible = false
		#audio_disabled_texture.visible = false
	else:
		if gay_theme.playing:
			gay_theme.stop()


func _on_authenticated() -> void:
		gay_mode = true
		#window.visible = false
		cubigor_spawner()
