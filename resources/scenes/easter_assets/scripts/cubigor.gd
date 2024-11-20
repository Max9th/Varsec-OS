@icon("res://resources/sprites/easteregg_icon.png")
extends Node3D

@onready var sfx: AudioStreamPlayer = $others/sfx
@onready var mesh: MeshInstance3D = $objects/mesh
@onready var mesh1: MeshInstance3D = $objects/mesh1
@onready var mesh2: MeshInstance3D = $objects/mesh2
@onready var mesh3: MeshInstance3D = $objects/mesh3
@onready var mesh4: MeshInstance3D = $objects/mesh4
@onready var mesh5: MeshInstance3D = $objects/mesh5

var cubigor_mode: bool = false

signal cubigorbk

func _process(delta: float) -> void:
	if cubigor_mode and sfx.playing == false:
		sfx.play()
		cubigorbk.emit()
	elif cubigor_mode == false:
		sfx.stop()
	if cubigor_mode:
		mesh.rotate_x(5 * delta)
		mesh1.rotate_y(5 * delta)
		mesh2.rotate_y(5 * delta)
		mesh3.rotate_x(5 * delta)
		mesh4.rotate_x(5 * delta)
		mesh5.rotate_y(5 * delta)

func _on_authenticated_cubigor() -> void:
	cubigor_mode = true
	get_tree().call_group("main_scene", "easter_state_manager", "cubigor", true)

func _on_mm_stop() -> void:
	cubigor_mode = false
