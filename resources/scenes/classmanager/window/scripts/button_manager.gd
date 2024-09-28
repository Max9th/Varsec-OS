extends VBoxContainer

@onready var aulas: Array = [
	$"../aulas/aula1",
	$"../aulas/aula2",
	$"../aulas/aula3",
	$"../aulas/aula4",
	$"../aulas/aula5"
]

func _ready() -> void:
	hide_all_aulas()

# Function to hide all aula nodes
func hide_all_aulas() -> void:
	for aula in aulas:
		aula.visible = false

# Function to show a specific aula
func show_aula(index: int) -> void:
	hide_all_aulas()  # Hide all aulas first
	if index >= 0 and index < aulas.size():
		aulas[index].visible = true  # Show the selected aula

# Connect these functions to the respective button presses
func _on_aula_1_pressed() -> void:
	show_aula(0)

func _on_aula_2_pressed() -> void:
	show_aula(1)

func _on_aula_3_pressed() -> void:
	show_aula(2)

func _on_aula_4_pressed() -> void:
	show_aula(3)

func _on_aula_5_pressed() -> void:
	show_aula(4)
