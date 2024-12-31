class_name Desktop_vos
extends Node

@onready var background: TextureRect = $Contents/Core_components/Background
@onready var audioplayer: AudioStreamPlayer = $Other_components/Audioplayer

func _ready() -> void:
	update_time()
	canvas_layer.show()
	$vfx/CanvasLayer/ColorRect.material = load("res://resources/shaders/shader_crt.tres")
	connect_to_corec()
	print(Corec.Database["class_data"]["1bim"]["aula_1"]["title"])
	print(Corec.Database["class_data"]["1bim"]["aula_1"]["text"])

func connect_to_corec():
	Corec.connect("wallpaper_change", wallpaper_change)
	Corec.connect("change_audio", change_audio)
	Corec.connect("vfx_switch", change_vfx)
	Corec.connect("cng_vfx_shader", switch_vfx)
	Corec.connect("trigger_event_x", trigger_evx)
	Corec.connect("interrupt_event_x", stop_evx)

#region Callable features

func wallpaper_change(texture: String):
	background.texture = load(texture)

func change_audio(audio:String):
	audioplayer.stream = load(audio)
	audioplayer.play()

var vfx_status: bool = true

func change_vfx(shader):
	$vfx/CanvasLayer/ColorRect.material = load(shader)

func switch_vfx():
	vfx_status = !vfx_status
	if vfx_status == true:
		canvas_layer.show()
	else:
		canvas_layer.hide()

func trigger_evx():
	$vfx/CanvasLayer/ColorRect.material = load("res://resources/shaders/vignette.tres")

func stop_evx():
	$vfx/CanvasLayer/ColorRect.material = load("res://resources/shaders/shader_crt.tres")

#endregion

#region Core components

#region Time manager

@onready var date_label: Label = $Contents/Core_components/Panel/Time_manager/Date_label
@onready var time_label: Label = $Contents/Core_components/Panel/Time_manager/Time_label

func update_time() -> void:
	var date_dict: Dictionary = Time.get_datetime_dict_from_system()
	time_label.text = "%02d:%02d" % [date_dict.hour, date_dict.minute]
	date_label.text = "%02d/%02d/%d" % [date_dict.day, date_dict.month, date_dict.year]

func _on_time_update_timer_timeout() -> void:
	update_time()
	print("time updated!")

#endregion

@onready var canvas_layer: CanvasLayer = $vfx/CanvasLayer



#endregion
