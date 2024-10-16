@icon("res://resources/sprites/folder.png")
extends TextureButton

@onready var filenamelabel: Label = $selected_panel/HBoxContainer/filename
@onready var timer: Timer = $Timer
@onready var select_audio: AudioStreamPlayer = $select_audio
@onready var filename_colorable: Label = $filename
@onready var selected_panel: PanelContainer = $selected_panel
@onready var text_icon2: TextureRect = $selected_panel/HBoxContainer/text_icon
@onready var file_icon2: TextureRect = $file_icon

@export_category("Folder settings")
@export_multiline var filename: String
@export var file_icon: Texture
@export var text_icon: Texture

@export_subgroup("Textures")
@export var texture_n: Texture
@export var texture_h: Texture
#@export var texture_p: String
@export var texture_d: Texture

@export_subgroup("Link Document")
@export var is_link: bool
@export var link: String

@export_subgroup("Pre-instantiated Window")
@export var is_window_present: bool
@export var window_link: NodePath

@export_subgroup("Instantiated Window")
@export var is_instantiated: bool
@export var window_path: String = "Assign path"
@export var where_to_instantiate: NodePath

var selected: bool = false
var timer_running: bool = false
var is_mouse_hover: bool
var window_exists

func _ready() -> void:
	selected_panel.visible = false
	filenamelabel.text = filename
	filename_colorable.text = filename
	text_icon2.texture = text_icon
	file_icon2.texture = file_icon
	# --- Define provided custom textures ---
	texture_normal = texture_n
	texture_pressed = texture_n
	#texture_pressed = texture_p
	texture_hover = texture_h
	texture_disabled = texture_d
	# --- Set default textures if no custom textures are provided ---
	if texture_n == null:
		texture_normal = load("res://resources/sprites/folder.png")
		print("Error: Texture_n found. Default loaded")
	if texture_h == null:
		texture_hover = load("res://resources/sprites/folderopen.png")
		print("Error: Texture_h found. Default loaded")
	#if texture_p == "":
		#texture_pressed = load("res://resources/sprites/folder.png")
		#print("Error: Texture_p found. Default loaded")
	if texture_d == null:
		texture_disabled = load("res://resources/sprites/folderdisabled.png")
		print("Error: Texture_d found. Default loaded")
	if filename == "":
		filenamelabel.text = "folder"
		filename_colorable.text = "folder"

func _process(_delta: float) -> void:
	timer_running = not timer.is_stopped()

func select():
	if !timer_running:
		if !selected:
			SelectionManager.set_selected(self)
			selected = true
			selected_panel.visible = true
			timer.start()
			select_audio.play()
		else:
			deselect()
	elif selected and timer_running:
		spawnwindow()

func deselect():
	selected = false
	selected_panel.visible = false

func _on_pressed() -> void:
	select()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and is_mouse_hover == false:
		selected_panel.visible = false

func _on_mouse_entered() -> void:
	is_mouse_hover = true

func _on_mouse_exited() -> void:
	is_mouse_hover = false

func spawnwindow():
	if is_instantiated and !window_exists:
		var scene = load(window_path)
		if scene == null:
			print("Error: Unable to load scene:", window_path)
			return
		var path_node = get_node(where_to_instantiate)
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
	elif is_link:
		OS.shell_open(link)


func _on_main_scene_textcolorchange(textcolor: bool) -> void:
	if textcolor:
		filename_colorable.label_settings.font_color = Color(1,1,1)
	else:
		filename_colorable.label_settings.font_color = Color(0,0,0)

func window_state():
	window_exists = false
