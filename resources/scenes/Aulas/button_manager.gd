extends VBoxContainer

@onready var body_text: Label = $"../body_text"
@onready var body_text_2: Label = $"../body_text/body_text2"
@onready var aula_1: Button = $aula1
@onready var aula_2: Button = $aula2
@onready var aula_3: Button = $aula3
@onready var aula_4: Button = $aula4
@onready var aula_5: Button = $aula5

func _on_aula_1_pressed() -> void:
	body_text.text = aula_1.text
	body_text.visible = true
