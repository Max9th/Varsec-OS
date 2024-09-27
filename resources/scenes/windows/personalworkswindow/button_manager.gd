extends VBoxContainer


@onready var body_text: Label = $"../body_text"
@onready var personal: Control = $"../body_text/personal"
@onready var tab: Button = $tab

func _ready() -> void:
	personal.visible = false

func _on_tab_pressed() -> void:
	body_text.text = tab.text
	personal.visible = true
