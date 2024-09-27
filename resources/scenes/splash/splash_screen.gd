extends CanvasLayer

@onready var ifgtimer: Timer = $IFGtimer
@onready var changescenetimer: Timer = $changescene
@onready var shineanimator: AnimatedSprite2D = $MAX/AnimatedSprite2D
@onready var ifg: Control = $IFG
@onready var max_node: Control = $MAX
@onready var crt: ColorRect = $crt
@onready var sfx: AudioStreamPlayer = $sfx

@onready var splash_subscreen: CanvasLayer = $"."

@export var Full_boot = true

var clicknumber = 0
var seconds_passed = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Full_boot == true:
		ifgtimer.start()
		ifg.visible = true
		crt.visible = true
		sfx.playing = true
		splash_subscreen.visible = true
	else:
		splash_subscreen.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if clicknumber >= 2:
		finish_boot()
func _on_if_gtimer_timeout() -> void:
	max_node.visible = true
	ifg.visible = false
	shineanimator.play("shine")
func _on_changescene_timeout() -> void:
	finish_boot()
func _on_animated_sprite_2d_animation_finished() -> void:
	changescenetimer.start()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		clicknumber += 1
func finish_boot():
	splash_subscreen.visible = false
	sfx.playing = false
