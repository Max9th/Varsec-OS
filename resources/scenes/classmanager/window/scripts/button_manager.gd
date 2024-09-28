extends VBoxContainer

@onready var aula_1: Button = $aula1
@onready var aula_2: Button = $aula2
@onready var aula_3: Button = $aula3
@onready var aula_4: Button = $aula4
@onready var aula_5: Button = $aula5
@onready var body_text: Label = $"../body_text"
@onready var aula_0: Control = $"../body_text/aula0"

func _ready() -> void:
	aula_0.visible = false

func _on_aula_1_pressed() -> void:
	aula_0.visible = true
