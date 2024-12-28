@icon("res://resources/sprites/folder.png")
extends TextureButton
class_name Folder_varsec

@onready var file_label: Label = $selected_panel/HBoxContainer/filename
@onready var timer: Timer = $Timer
@onready var select_audio: AudioStreamPlayer = $select_audio
@onready var selected_panel: PanelContainer = $selected_panel
@onready var text_icon2: TextureRect = $selected_panel/HBoxContainer/text_icon
@onready var file_icon2: TextureRect = $file_icon

@export_category("Folder settings")
@export_multiline var filename: String
@export var file_icon: Texture
#@export var has_text_icon: bool
@export var text_icon: Texture
@export var text_color: Color

@export_subgroup("Link Document")
@export var is_web_link: bool
@export var link: String

@export_subgroup("Pre-instantiated Window")
@export var is_window_present: bool
@export var window_link: NodePath

@export_subgroup("Instantiated Window")
@export var is_instantiated: bool
@export var window_path: String
@export var where_to_instantiate: NodePath

var selected: bool = false
var timer_running: bool = false
var is_mouse_hover: bool
var window_exists: bool

func _ready() -> void:
	selected_panel.self_modulate.a = 0
	file_label.label_settings.font_color = text_color
	file_label.text = filename
	#if has_text_icon:
		#text_icon2.texture = text_icon
	#else:
		#text_icon2.hide()
	file_icon2.texture = file_icon
	if filename == "":
		file_label.text = "folder"

func _process(_delta: float) -> void:
	timer_running = not timer.is_stopped()

func select():
	if !timer_running:
		if !selected:
			SelectionManager.set_selected(self)
			selected = true
			selected_panel.self_modulate.a = 1
			file_label.label_settings.font_color = Color(0, 0, 0, 1)
			timer.start()
			select_audio.play()
		else:
			deselect()
	elif selected and timer_running:
		spawnwindow()

func deselect():
	selected = false
	selected_panel.self_modulate.a = 0
	file_label.label_settings.font_color = text_color

func _on_pressed() -> void:
	select()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and is_mouse_hover == false:
		selected_panel.self_modulate.a = 0
		file_label.label_settings.font_color = text_color

func _on_mouse_entered() -> void:
	is_mouse_hover = true

func _on_mouse_exited() -> void:
	is_mouse_hover = false

func spawnwindow():
	if is_instantiated and !window_exists:
		var scene = load(window_path)
		var path_node = get_node(where_to_instantiate)
		if scene == null:
			print("Error: Unable to load scene:", window_path)
			return
		if path_node:
			var new_window = scene.instantiate()
			path_node.add_child(new_window)
			new_window.position.x = self.position.x + self.size.x + 20
			new_window.position.y = self.position.y
			new_window.visible = true
			window_exists = true
		else:
			print("Error: window node not found:", where_to_instantiate)
	elif is_window_present:
		get_node(window_link).show()
	elif is_web_link:
		OS.shell_open(link)

func window_state():
	window_exists = false

func change_text_color(new_color: Color):
	text_color = new_color
	file_label.label_settings.font_color = text_color
