extends CanvasLayer

@onready var ifgtimer: Timer = $IFG/IFGtimer
@onready var ifg: Control = $IFG
@onready var max_node: Control = $MAX
@onready var crt: ColorRect = $crt
@onready var sfx: AudioStreamPlayer = $sfx
@onready var copyright: Label = $Copyright
@onready var skip: TextureButton = $skip
@onready var splash_subscreen: CanvasLayer = $"."
@onready var glintstart: Timer = $MAX/glintstart
@onready var maxtimer: Timer = $MAX/Maxtimer
@onready var glint: ColorRect = $MAX/center/TextureRect/glint
@onready var start: Timer = $start

@export var Full_boot = true

var seconds_passed = 0
var clicknumber = 0

signal finished_boot

func _ready() -> void:
	if Full_boot == true:
		start.start()
		visible = true
		crt.show()
		sfx.play()
	else:
		finish_boot()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		clicknumber += 1
	if clicknumber >= 2:
		finish_boot()
func _on_if_gtimer_timeout() -> void:
	max_node.show()
	ifg.hide()
	glintstart.start()

func _on_glintstart_timeout() -> void:
	glint.show()
	maxtimer.start()
	fade_out_bus_volume()


func _on_maxtimer_timeout() -> void:
	finish_boot()

func _on_skip_pressed() -> void:
	finish_boot()

func finish_boot():
	finished_boot.emit()
	sfx.stop()
	self.queue_free()

func _on_start_timeout() -> void:
		ifgtimer.start()
		ifg.show()
		copyright.show()
		skip.show()

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
