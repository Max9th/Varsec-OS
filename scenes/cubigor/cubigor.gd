extends Node3D

@onready var cubigor_theme: AudioStreamPlayer = $Cubigor_theme
@onready var mesh1: MeshInstance3D = $MeshInstance3D
signal cubigorbk
@onready var mesh_2: MeshInstance3D = $mesh2
@onready var mesh_3: MeshInstance3D = $mesh3
@onready var mesh_4: MeshInstance3D = $mesh4
@onready var mesh: MeshInstance3D = $mesh
@onready var mesh_5: MeshInstance3D = $mesh5

var cubigor_mode: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cubigor_mode:
		mesh.rotate_x(5 * delta)
		mesh1.rotate_y(5 * delta)
		mesh_2.rotate_y(5 * delta)
		mesh_3.rotate_x(5 * delta)
		mesh_4.rotate_x(5 * delta)
		mesh_5.rotate_y(5 * delta)
func cubigor_spawner():
	if cubigor_mode:
		if not cubigor_theme.playing:
			cubigor_theme.play()
		cubigorbk.emit()
		#background.visible = false
		#audio_disabled_texture.visible = false
	else:
		if cubigor_theme.playing:
			cubigor_theme.stop()


func _on_authenticate_popup_authenticated() -> void:
		cubigor_mode = true
		#window.visible = false
		cubigor_spawner()
