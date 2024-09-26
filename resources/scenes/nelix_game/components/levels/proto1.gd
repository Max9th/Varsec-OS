extends Node3D

@onready var player = $Player

# $set/CSGBox3D MUST BE REPLACED BY A MESHINSTANCE3D AFTER WE ARE DONE PROTOTYPING, YOU DUMB FUCK
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)

func _on_area_3d_body_entered(body):
	body.position.y = 15
	body.position.x = 0
	body.position.z = 0
