extends TextureButton

@onready var filenamelabel: Label = $selected_panel/filename
@onready var timer: Timer = $Timer
@onready var select_audio: AudioStreamPlayer = $select_audio
@onready var filenamelabel_v: Label = $filename
@onready var selected_panel: PanelContainer = $selected_panel

@export var filename: String

@export_category("Textures")
@export var texture_n: String
@export var texture_h: String
@export var texture_p: String
@export var texture_d: String

@export_category("Pre-instantiated Window")
@export var is_window_present: bool
@export var window_link: NodePath

@export_category("Instantiated Window")
@export var window_path: String = "Assign path"
@export var where_to_instantiate: NodePath

var selected: bool = false
var timer_running: bool = false
var is_mouse_hover: bool

func _ready() -> void:
	selected_panel.visible = false
	filenamelabel.text = filename
	filenamelabel_v.text = filename
	#selected_panel.size.x = filenamelabel.size.x + 20
	# --- Define provided custom textures ---
	texture_normal = load(texture_n)
	texture_pressed = load(texture_h)
	texture_hover = load(texture_p)
	texture_disabled = load(texture_d)
	# --- Set default textures if no custom textures are provided ---
	if texture_n == "":
		texture_normal = load("res://resources/sprites/folder.png")
		print("Error: Texture_n found. Default loaded")
	if texture_h == "":
		texture_hover = load("res://resources/sprites/folderopen.png")
		print("Error: Texture_h found. Default loaded")
	if texture_p == "":
		texture_pressed = load("res://resources/sprites/folder.png")
		print("Error: Texture_p found. Default loaded")
	if texture_d == "":
		texture_disabled = load("res://resources/sprites/folderdisabled.png")
		print("Error: Texture_d found. Default loaded")
	if filename == "":
		filenamelabel.text = "folder"
		filenamelabel_v.text = "folder"

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
	if !is_window_present:
		var scene = load(window_path)  # Ensure 'window' points to your panel scene path
		if scene == null:
			print("Error: Unable to load scene:", window_path)
			return
		var window_node = get_node(where_to_instantiate)
		if window_node:
			var new_window = scene.instantiate() 
			window_node.add_child(new_window) 
			new_window.position = Vector2(100, 100)
			new_window.visible = true
		else:
			print("Error: window node not found:", where_to_instantiate)
	else:
		get_node(window_link).show()
