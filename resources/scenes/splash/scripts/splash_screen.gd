extends CanvasLayer

@onready var ifgtimer: Timer = $IFG/IFGtimer
@onready var changescenetimer: Timer = $changescene
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

@export var Full_boot = true

var seconds_passed = 0
var clicknumber = 0

func _ready() -> void:
	if Full_boot == true:
		ifgtimer.start()
		ifg.show()
		crt.show()
		sfx.play()
		visible = true
		copyright.show()
		skip.show()
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

func _on_changescene_timeout() -> void:
	finish_boot()
func _on_animated_sprite_2d_animation_finished() -> void:
	changescenetimer.start()

func _on_glintstart_timeout() -> void:
	glint.show()
	maxtimer.start()

func _on_maxtimer_timeout() -> void:
	finish_boot()

func _on_skip_pressed() -> void:
	finish_boot()

func finish_boot():
	visible = false
	sfx.stop()
