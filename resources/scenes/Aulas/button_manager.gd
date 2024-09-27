extends VBoxContainer

@onready var aula_0: Control = $"../body_text/aula0"
@onready var aula_1: Button = $aula1
@onready var aula_2: Button = $aula2
@onready var aula_3: Button = $aula3
@onready var aula_4: Button = $aula4
@onready var aula_5: Button = $aula5
@onready var body_text: Label = $"../body_text/aula0/body_text"

func _on_aula_1_pressed() -> void:
	body_text.text = aula_1.text
	aula_0.visible = true
