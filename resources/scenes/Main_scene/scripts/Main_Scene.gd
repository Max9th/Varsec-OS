@icon("res://resources/sprites/Themaxwellcompany_dark.png")
extends Control

#MMMMMMMMMMNdddddddxxxKMMMMMMXxxxxddddddXMMMMMMMMMM
#MMMMMMMMMMO          dMMMMMMk          xMMMMMMMMMM
#MMMMMMMMMMO   lkkkkkkXMMMMMMNkkkkkko   xMMMMMMMMMM
#MMMMMMMMMMO   OMMMMMMMMMMMMMMMMMMMMK   xMMMMMMMMMM
#MMMMMMMMMMO   OMMMMMMMMMM.  :MMMMMMK   xMMMMMMMMMM
#MMMMMMMMMMK,,,KMMWOOOOOOO   ;MMMMMMX,,,OMMMMMMMMMM
#MMMMMMMMMMMMMMMMMX          ;MMMMMMMMMMMMMMMMMMMMM
#MMMMMMMMMMMMMMMMMWooo'      .lllXMMMMMMMMMMMMMMMMM
#MMMMMMMMMMMMMMMMMMMMMc          0MMMMMMMMMMMMMMMMM
#MMMMMMMMMM0'''0MMMMMMc   O000000WMMX'''OMMMMMMMMMM
#MMMMMMMMMMO   OMMMMMMl...NMMMMMMMMMK   xMMMMMMMMMM
#MMMMMMMMMMO   OMMMMMMMMMMMMMMMMMMMMK   xMMMMMMMMMM
#MMMMMMMMMMO   cxxxkkkXMMMMMMXxkkxxxo   xMMMMMMMMMM
#MMMMMMMMMMO          dMMMMMMk          xMMMMMMMMMM
#MMMMMMMMMMNxxxxxxxkkkXMMMMMMNkkkxxxxxxxXMMMMMMMMMM

	# The Maxwell Company

@onready var ambientsound: AudioStreamPlayer = $ambientsound
@onready var splash_screen: CanvasLayer = $splash_screen
@onready var background: TextureRect = $desktop/background
@onready var time: Label = $desktop/panel/Panel/time
@onready var date: Label = $desktop/panel/Panel/date
@onready var sfx_button: Button = $desktop/panel/Panel/sfx_button
@onready var sfx_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/sfx_button_sprite
@onready var vfx: ColorRect = $vfx
@onready var vfx_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/vfx_button_sprite
@onready var windows: Control = $desktop/windows
@onready var easter_button: Button = $desktop/panel/Panel/easter_button
@onready var easter_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/easter_button_sprite
@onready var music: TextureButton = $desktop/Folders/rightvboxcon/music
@onready var folders: Control = $desktop/Folders
@onready var panel: Panel = $desktop/panel/Panel
@onready var logo_proj_name: Label = $desktop/portfolio
@onready var class_manager: Panel = $desktop/windows/class_manager

@onready var vfx_texture = preload("res://resources/sprites/vfx.png")
@onready var disabled_vfx_texture = preload("res://resources/sprites/disabledvfx.png")

@onready var default_bk_texture = preload("res://resources/sprites/bk.png")

var playaudio: bool = false
var textcolor: bool = true

signal stop
signal textcolorchange
signal welcome_display

var easter_state: bool = false

func _on_power_button_pressed() -> void:
	self.queue_free()
	get_tree().quit()

func _ready() -> void:
	vfx.visible = true
	vfx_button_sprite.texture = vfx_texture
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	easter_button_sprite.visible = false
	easter_button.disabled = true
	windows.position.x = 0
	update_time()
	if JavaScriptBridge.eval("checkVisit();"):
		var result = JavaScriptBridge.eval("checkVisit();")
		if result:
			pass
		else:
			class_manager.show()
			welcome_display.emit()
	else:
		print("JavaScriptBridge not available. Not running in a web environment.")

func _on_vfx_button_pressed() -> void:
	vfx.visible = !vfx.visible
	if !vfx.visible:
		vfx_button_sprite.texture = load("res://resources/sprites/disabledvfx.png")
	else:
		vfx_button_sprite.texture = load("res://resources/sprites/vfx.png")

# --- EASTEREGG MANAGER SUBSECTION ---

@onready var easter_scenes: Array[Node] = [
	$deziangle,
	$cubigor,
	$nightcity,
	$gax
]

func show_only_node(target_node: Node) -> void:
	for node in easter_scenes:
		node.visible = (node == target_node)

func hide_all_nodes() -> void:
	for node in easter_scenes:
		node.visible = false

func show_all_nodes() -> void:
	for node in easter_scenes:
		node.visible = true

func easter_state_manager(easter_name: String, is_3d: bool):
	easter_button_sprite.show()
	easter_button.disabled = false
	logo_proj_name.hide()
	textcolorchange.emit(true)
	if is_3d == true:
		background.hide()
	match easter_name:
		"deziangle":
			show_only_node($deziangle)
		"cubigor":
			show_only_node($cubigor)
		"gax":
			show_only_node($gax)
		"nightcity":
			show_only_node($nightcity)
			background.texture = load("res://resources/sprites/nightcity.png")
			var stylebox = load("res://resources/scenes/Main_scene/Main_scene.tscn::StyleBoxFlat_yma61")
			stylebox.bg_color = Color(0.19, 0.221, 0.306)
			panel.set("custom_styles/panel", stylebox)

func _on_easter_button_pressed() -> void:
	background.show()
	background.texture = default_bk_texture
	logo_proj_name.show()
	stop.emit()
	easter_button.disabled = true
	easter_button_sprite.hide()
	playaudio = true

func update_time() -> void:
	var date_dict: Dictionary = Time.get_datetime_dict_from_system()
	time.text = "%02d:%02d" % [date_dict.hour, date_dict.minute]
	date.text = "%02d/%02d/%d" % [date_dict.day, date_dict.month, date_dict.year]

func _on_timer_timeout() -> void:
	update_time()

# --- WALLPAPER MANAGER SUBSECTION ---
# ATTENTION this is a wip

#var wallpaper_map: Dictionary = {
		#0: { "texture": "res://resources/sprites/nightcity.png", "textcolor": true },
		#1: { "texture": "res://resources/sprites/classmanagerassets/xilogravados.jpeg", "textcolor": false },
#}
#
#func set_wallpaper(wallpaper_int: int) -> void:
	#var wallpaper_data = wallpaper_map.get(wallpaper_int, null)
	#if wallpaper_data:
		#background.texture = load(wallpaper_data["texture"])
		#textcolor = wallpaper_data["textcolor"]
	#textcolorchange.emit(textcolor)


#func _on_walpaper_manager_changebk(wallpaper_int: int) -> void:
	#logo_proj_name.hide()
	#if !easter:
		#match wallpaper_int:
			#0:
				#background.show()
				#background.texture = load("res://resources/sprites/45.png")
				#textcolor = true
			#1:
				#background.show()
				#background.texture = load("res://resources/sprites/classmanagerassets/xilogravados.jpeg")
				#textcolor = false
			#3:
				#background.show()
				#background.texture = load("res://resources/sprites/federar.png")
				#textcolor = false
			#4:
				#background.show()
				#background.texture = load("res://resources/sprites/belathazar.png")
				#textcolor = false
			#5:
				#background.show()
				#background.texture = load("res://resources/sprites/personalworkmanagerassets/skely.png")
				#textcolor = true
			#6:
				#background.show()
				#background.texture = load("res://resources/sprites/personalworkmanagerassets/citylandscape2.png")
				#textcolor = true
			#7:
				#background.show()
				#background.texture = load("res://resources/sprites/personalworkmanagerassets/MATRIX MADNESS.png")
				#textcolor = false
			#8:
				#background.texture = load("res://resources/sprites/bk.png")
				#textcolor = true
				#logo_proj_name.show()
				#background.show()
			#2:
				#background.hide()
				#textcolor = false
				#logo_proj_name.hide()
#
		#textcolorchange.emit(textcolor)
