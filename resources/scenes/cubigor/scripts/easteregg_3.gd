extends Node2D

@onready var sfx: AudioStreamPlayer = $sfx
@onready var sfx_2: AudioStreamPlayer = $sfx2
@onready var video: VideoStreamPlayer = $Video
@onready var nelixwindow: Panel = $"../desktop/windows/nelixwindow"
@onready var windowname: Label = $"../desktop/windows/nelixwindow/windowname"
@onready var bodytext: Label = $"../desktop/windows/nelixwindow/bodytext"

signal disablebk

func _on_authenticated_lies():
	sfx.stream = load("res://resources/audio/morse.wav")
	sfx.play()
	sfx_2.play()
	video.play()
	disablebk.emit()


func _on_hah_pressed() -> void:
	nelixwindow.visible = true
	windowname.text = ""
	bodytext.text = ""
