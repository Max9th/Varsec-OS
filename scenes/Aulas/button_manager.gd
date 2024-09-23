extends VBoxContainer

@onready var body_text: Label = $"../body_text"
@onready var aula_1: Button = $aula1
@onready var aula_2: Button = $aula2
@onready var aula_3: Button = $aula3
@onready var aula_4: Button = $aula4
@onready var aula_5: Button = $aula5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_aula_1_pressed() -> void:
	body_text.text = aula_1.text
