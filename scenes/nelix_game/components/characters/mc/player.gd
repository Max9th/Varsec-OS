extends CharacterBody3D

@onready var head = $head
@onready var crouchcollision = $crouchcollision
@onready var standingcollision = $standingcollision
@onready var ray_cast_3d = $RayCast3D
@onready var player = $"."
@onready var velocity_label_x = $UI/Debug/velocity_label_x
@onready var velocity_label_y = $UI/Debug/velocity_label_y
@onready var velocity_label_z = $UI/Debug/velocity_label_z

var current_speed: float

var crouch_speed = 3.0
var sprint_speed = 10.0
var walking_speed = 5.0

#const JUMP_VELOCITY = 4.5
var jump_velocity: float = 5
var jump_peak_time:float = .5
var jump_fall_time:float = .5
var jump_height:float = 2
var jump_distance:float = 4.0

const mouse_sen = 0.4

var direction = Vector3.ZERO

var lrp_speed = 10.0

var crouch_depth = -0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var jump_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var fall_gravity: float = 5.0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	calc_move_param()
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sen))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sen))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _process(_delta):
	debugmenu()

func _physics_process(delta):
	if Input.is_action_pressed("crouch"):
		current_speed = crouch_speed
		head.position.y = lerp(head.position.y,crouch_depth,delta*lrp_speed)
		crouchcollision.disabled = false
		standingcollision.disabled = true
	elif !ray_cast_3d.is_colliding():
		head.position.y = lerp(head.position.y,0.7,delta*lrp_speed)
		crouchcollision.disabled = true
		standingcollision.disabled = false
		if Input.is_action_pressed("sprint") and is_on_floor():
			current_speed = sprint_speed
		else:
			current_speed = walking_speed
	if not is_on_floor():
		if velocity.y>0:
			velocity.y -= jump_gravity * delta
		else:
			velocity.y -= fall_gravity * delta

		# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y =  jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move-left", "move-right", "move-north", "move-south")
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*lrp_speed)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	move_and_slide()

func calc_move_param()->void:
		jump_gravity = (2*jump_height)/pow(jump_peak_time,2)
		fall_gravity = (2*jump_height)/pow(jump_fall_time,2)
		jump_velocity = jump_gravity * jump_peak_time
		current_speed = jump_distance/(jump_peak_time+jump_fall_time)
		
func debugmenu():
	velocity_label_x.text = "Velocity.x = " + str("%.2f" % velocity.x)
	velocity_label_y.text = "Velocity.y = " + str("%.2f" % velocity.y)
	velocity_label_z.text = "Velocity.z = " + str("%.2f" % velocity.z)
