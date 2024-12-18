extends CanvasLayer

@onready var ifgtimer: Timer = $ifg_bootscreen/ifg_bootscreen_timer
@onready var ifg_bootscreen: Control = $ifg_bootscreen
@onready var max_node: Control = $MAX
@onready var vfx: ColorRect = $vfx
@onready var sfx: AudioStreamPlayer = $sfx
@onready var copyright: Label = $Copyright
@onready var splash_subscreen: CanvasLayer = $"."
@onready var glintstart: Timer = $MAX/glintstart
@onready var maxtimer: Timer = $MAX/Maxtimer
@onready var glint: ColorRect = $MAX/center/TextureRect/glint
@onready var start: Timer = $start

var clicknumber: int = 0

signal finished_boot

func _ready() -> void:
	start.start()
	visible = true
	vfx.show()
	sfx.play()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		clicknumber += 1
	if clicknumber >= 2:
		skip()

func _on_start_timeout() -> void:
		ifgtimer.start()
		ifg_bootscreen.show()
		copyright.show()
		$skip.show()

func _on_if_gtimer_timeout() -> void:
	ifg_bootscreen.hide()
	max_node.show()
	glintstart.start()

func _on_glintstart_timeout() -> void:
	glint.show()
	maxtimer.start()
	fade_out_bus_volume()

func _on_maxtimer_timeout() -> void:
	skip()

var bus_name = "boot"
var fade_duration = 9.0
var target_volume = -80.0
@onready var node: Node = $Node

func fade_out_bus_volume():
	var current_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name))
	var tween = create_tween()
	tween.tween_method(Callable(self, "_set_bus_volume"), current_volume, target_volume, fade_duration)

func _set_bus_volume(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), volume)

func _on_skip_pressed() -> void:
	skip()

func skip():
	finished_boot.emit()
	sfx.stop()
	self.queue_free()
