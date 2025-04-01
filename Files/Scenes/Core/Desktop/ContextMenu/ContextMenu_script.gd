class_name ContextMenu_vos extends PanelContainer

@onready var container: VBoxContainer = $MarginContainer/VBoxContainer

var current_index:int = 0
var is_mouse_in: bool = false

func _ready() -> void:
	clear()
	custom_minimum_size =  Vector2(144, 0)

func clear():
	for child in container.get_children():
		child.queue_free()

func add_button(text: String = "Lorem"):
	current_index += 1
	var new_button = Button_vos.new()
	new_button.index = current_index
	new_button.text = text
	container.add_child(new_button)

func remove_item(index: int):
	for child in get_children():
		if (child is Button_vos or child is HSeparator_vos) and child.index == index:
			child.queue_free()

func add_separator():
	current_index += 1
	var separator = HSeparator_vos.new()
	separator.index = current_index
	container.add_child(separator)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and is_mouse_in == false:
		#self.queue_free()
		pass

func _on_mouse_entered() -> void:
	is_mouse_in = true


func _on_mouse_exited() -> void:
	is_mouse_in = false
