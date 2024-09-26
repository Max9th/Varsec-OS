extends CharacterBody3D

@onready var label = $stateindicator
@onready var eyes = $eyes
@onready var shoottimer = $shoottimer
@onready var ray_cast_3d = $RayCast3D
@onready var nav = $NavigationAgent3D
@onready var timer = $Timer

var Global

var target

var speed = 1.0
var accel = 10

const turn_speed = 2

enum {
	IDLE,
	ALERT,
	COVER,
	}

var state = IDLE

func _on_sightrange_body_entered(body):
	if body.is_in_group("player"):
		state = ALERT
		target = body
		shoottimer.start()

func _on_sightrange_body_exited(_body):
	state = IDLE
	shoottimer.stop()
	
func _on_shoottimer_timeout():
	if ray_cast_3d.is_colliding():
		if ray_cast_3d.get_collider().is_in_group("player"):
			label.text = "I'M GAAY"

func update_target_location(target_location):
	if state == ALERT:
		nav.set_target_position(target_location)

func _process(delta: float) -> void:
	match(state):
		IDLE:
			label.text = "idle"
		ALERT:
			label.text = "alert"
			eyes.look_at(target.global_transform.origin, Vector3.UP)
			rotate_y(deg_to_rad(eyes.rotation.y * turn_speed))
		COVER:
			label.text = "how?????"

func _physics_process(_delta: float) -> void:
	var destination = nav.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	
	velocity = direction * 5.0
	move_and_slide()
