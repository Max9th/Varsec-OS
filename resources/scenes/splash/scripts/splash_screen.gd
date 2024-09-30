extends CanvasLayer

@onready var ifgtimer: Timer = $IFG/IFGtimer
@onready var changescenetimer: Timer = $changescene
@onready var shineanimator: AnimatedSprite2D = $MAX/AnimatedSprite2D
@onready var ifg: Control = $IFG
@onready var max_node: Control = $MAX
@onready var crt: ColorRect = $crt
@onready var sfx: AudioStreamPlayer = $sfx
@onready var copyright: Label = $Copyright
@onready var skip: TextureButton = $skip

@onready var splash_subscreen: CanvasLayer = $"."

@export var Full_boot = true

var seconds_passed = 0
var clicknumber = 0

func _ready() -> void:
	if Full_boot == true:
		ifgtimer.start()
		ifg.visible = true
		crt.visible = true
		sfx.playing = true
		visible = true
		copyright.visible = true
		skip.visible = true
	else:
		finish_boot()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		clicknumber += 1
	if clicknumber >= 2:
		finish_boot()
func _on_if_gtimer_timeout() -> void:
	max_node.visible = true
	ifg.visible = false
	shineanimator.play("glint")

func _on_changescene_timeout() -> void:
	finish_boot()
func _on_animated_sprite_2d_animation_finished() -> void:
	changescenetimer.start()

func _on_skip_pressed() -> void:
	finish_boot()

func finish_boot():
	visible = false
	sfx.playing = false
