extends Node2D

@onready var sfx: AudioStreamPlayer = $sfx
@onready var sfx_2: AudioStreamPlayer = $sfx2
@onready var nelixwindow: Panel = $"../desktop/windows/nelixwindow"
@onready var hah: TextureButton = $"../desktop/Folders/rightvboxcon/h̴͉̋ò̸̜m̵̢͘ë̸̦ ̸̺͐s̶̘̀ẃ̷̙é̷͜e̵̻̓ṱ̷̏ ̵̞́h̴̝̀o̷̬͋m̶̠̐ḛ̶̍"
@onready var windowname: Label = $"../desktop/windows/nelixwindow/windowname"
@onready var bodytext: Label = $"../desktop/windows/nelixwindow/bodytext"
@onready var video: VideoStreamPlayer = $Video

signal disablebk

func _on_authenticated_lies():
	sfx.stream = load("res://resources/audio/morsecode_a7d8oc6h26dbp8mmuf1vcunasv.wav")
	sfx.play()
	sfx_2.play()
	video.play()
	disablebk.emit()


func _on_hah_pressed() -> void:
	nelixwindow.visible = true
	windowname.text = ""
	bodytext.text = ""