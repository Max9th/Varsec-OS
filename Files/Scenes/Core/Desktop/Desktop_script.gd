@icon("uid://yx7brorivehg")
extends Control

@export var program_storage: Node
@export var popup_storage_layer: Node
@export var system_panel: Node

@onready var vfx_layer: CanvasLayer = $VFXLayer
@onready var background: TextureRect = $Contents/Background/Background
@onready var os_billboards: Control = $Contents/Background/OSBillboards
@onready var _3d_background: SubViewportContainer = $"Contents/Background/3DBackground"

var vfx_status: bool = true
var music_status: bool = true
var default_background_image = preload("uid://cmcpsmaw4gejf")
var panel_stylebox_cache: StyleBoxFlat

func connect_core_signals():
	var signals:Dictionary = {
		"change_wallpaper_signal": change_wallpaper,
		"switch_vfx_status_signal": switch_vfx_status,
		"change_vfx_shader_signal": change_vfx_shader,
		"change_panel_colors_signal": change_panel_colors,
		"spawn_window_signal": spawn_window,
		"spawn_popup_signal": spawn_popup,
		"spawn_file_dialog_signal": spawn_file_dialog,
		"hide_billboards_signal": hide_billboards,
		"clear_popups": clear_popups,
		"clear_windows": close_all_programs,
	}

	for signal_name in signals.keys():
		if Core.has_signal(signal_name):
			Core.connect(signal_name, signals[signal_name])

func _ready() -> void:
	connect_core_signals()
	vfx_layer.show()
	Core.change_background_music()
	Core.play_secondary_track("uid://dyjjw70dem80q")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx_1"), 0)

#region Callable features

func spawn_window(window_path: StringName, window_pos: Vector2):
	var scene = load(window_path)
	if program_storage:
		var new_window = scene.instantiate()
		program_storage.add_child(new_window)
		new_window.position = window_pos
		new_window.global_position.x = clamp(new_window.global_position.x, 0, Core.viewport_size.x - new_window.size.x)
		new_window.global_position.y = clamp(new_window.global_position.y, Core.panel_height, Core.viewport_size.y - new_window.size.y)
		new_window.show()
		new_window.is_instance_type = true
	else:
		print("Error: No Program Storage node specified!")

func spawn_popup(popup_text: StringName, popup_name: StringName, has_pwd_query: bool):
	if popup_storage_layer:
		var popup: popup_window_vos = load(Core.popup_scene_uid).instantiate()
		popup.is_instance_type = true
		popup.can_close = true
		popup.show()
		popup.window_name_label.text = popup_name
		popup.popup_text_label.text = popup_text
		popup.has_pwd_query = has_pwd_query
		popup_storage_layer.add_child(popup)
	else:
		print("Error: No Popup Storage Layer specified!")

func spawn_file_dialog():
	if popup_storage_layer:
		var window = FileDialog.new()
		popup_storage_layer.add_child(window)
		window.filters = ["*.png", "*.jpeg"]
		window.show()
		window.size = Core.viewport_size
		window.position = Vector2(0,0)
		window.access = FileDialog.ACCESS_FILESYSTEM
		window.file_mode = FileDialog.FILE_MODE_OPEN_FILE
		window.position = Vector2(102, 184)
		window.use_native_dialog = false
	else:
		print("Error: No Popup Storage Layer specified!")

func change_panel_colors(color: Color):
	if not panel_stylebox_cache:
		panel_stylebox_cache = system_panel.get_theme_stylebox("panel").duplicate()
	panel_stylebox_cache.bg_color = color
	system_panel.add_theme_stylebox_override("panel", panel_stylebox_cache)

func change_wallpaper(path: StringName, is_3d: bool = false, path_to_3d_scene: StringName = &"uid://ctm4fp4tnsvm6"):
	if not path.is_empty():
		background.texture = load(path)
		background.show()
	else:
		print("Failed to load image: " + path + " Loading default.")
		background.texture = default_background_image
	if is_3d:
		background.hide()
		for child in _3d_background.get_node("3DBackrgoundViewport").get_children():
			child.queue_free()
		_3d_background.get_node("3DBackrgoundViewport").add_child(load(path_to_3d_scene).instantiate())

func change_vfx_shader(path_to_shader: StringName = &"uid://c7vnw4dnik7g3"):
	if !path_to_shader.is_empty():
		vfx_layer.get_node("VFXColorRect").material = load(path_to_shader)
	else:
		print("Error: No valid shader path/uid specified!")

func switch_vfx_status():
	if vfx_layer:
		vfx_status = !vfx_status
		if vfx_status == true:
			vfx_layer.show()
		else:
			vfx_layer.hide()
	else:
		print("Error: VFX Layer is missing!")

func clear_popups():
	for popup in popup_storage_layer.get_children():
		if popup is popup_window_vos:
			popup.close_window()

func close_all_programs():
	if program_storage:
		for window in program_storage.get_children():
			if window is window_vos:
				window.close_window()
	else:
		print("Error: No Program Storage speficied!")

var billboard_status: bool = true

func hide_billboards():
	billboard_status = !billboard_status
	if !billboard_status:
		os_billboards.hide()
	else:
		os_billboards.show()
#endregion
