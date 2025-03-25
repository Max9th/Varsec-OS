#@tool
@icon("uid://ch8stip28flkd")
class_name Folder_vos extends TextureButton

@onready var audioplayer: AudioStreamPlayer = $Other_components/Audioplayer
@onready var filename_label: Label = $Panel/HBoxContainer/Filename
@onready var timer: Timer = $Other_components/Timer
@onready var panel: PanelContainer = $Panel
@onready var text_icon: TextureRect = $Panel/HBoxContainer/TextIcon
@onready var file_icon: TextureRect = $FileIcon

@export_category("Folder settings")
@export_multiline var file_name: String
@export var file_icon_var: Texture = null
@export var text_icon_var: Texture = null
@export var default_filename_color_primary = Color(1, 1, 1, 1)
@export var default_filename_color_secondary = Color(0, 0, 0, 1)

enum Doc_type {Instance, pre_existent, link_type = -1}
@export var Type_of_doc: Doc_type
@export_subgroup("Link Document")
@export var link: String

@export_subgroup("Pre-instantiated Window")
@export var window_link: NodePath

@export_subgroup("Instantiated Window")
@export var window_path: String

var is_selected: bool = false

signal opened
signal selected
signal deselected

func _ready() -> void:
	filename_label.label_settings = filename_label.label_settings.duplicate(false)
	text_icon.hide()
	if text_icon_var == null:
		text_icon.queue_free()
	else:
		text_icon.texture = text_icon_var
	if file_icon_var == null:
		file_icon.queue_free()
	else:
		file_icon.texture = file_icon_var
	panel.self_modulate.a = 0
	filename_label.text = file_name
	filename_label.label_settings.font_color = default_filename_color_primary

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_pressed() -> void:
	var timer_running = not timer.is_stopped()
	if !timer_running:
		if !is_selected:
			select()
		else:
			deselect()
			if text_icon:
				text_icon.hide()
	elif is_selected and timer_running:
		open()
		deselect()

func select():
	is_selected = true
	selected.emit()
	if text_icon:
		text_icon.show()
	panel.self_modulate.a = 1
	filename_label.label_settings.font_color = default_filename_color_secondary
	timer.start()
	audioplayer.play()
	print(str(filename_label.text) + " Was is_selected! Ermager :O")

func deselect():
	if text_icon:
		text_icon.hide()
	deselected.emit()
	is_selected = false
	panel.self_modulate.a = 0
	filename_label.label_settings.font_color = default_filename_color_primary

var is_mouse_hover: bool

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and is_mouse_hover == false:
		deselect()

func _on_mouse_entered() -> void:
	is_mouse_hover = true

func _on_mouse_exited() -> void:
	is_mouse_hover = false

func open():
	opened.emit()
	match Type_of_doc:
		Doc_type.Instance:
			if not window_path.is_empty():
				Corec.open_program(window_path, Vector2(self.position.x + self.size.x + 80, Corec.panel_height))
				print("A window was spawned! by " + name)
			else:
				print("Failed to open window! " + name)
				Corec.send_notification("Failed to open window!")
		Doc_type.pre_existent:
			get_node(window_link).show()
			print("A window was opened! (pre-existent)")
		Doc_type.link_type:
			OS.shell_open(link)
			print("A link was opened")
