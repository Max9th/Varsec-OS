@icon("res://resources/sprites/Themaxwellcompany_dark.png")
class_name Desktop_vos
extends Node

@onready var background: TextureRect = $Contents/Core_components/Background
@onready var audioplayer: AudioStreamPlayer = $Other_components/Audioplayer
@onready var canvas_layer: CanvasLayer = $vfx/CanvasLayer
@onready var vfx_node: ColorRect = $vfx/CanvasLayer/ColorRect
@onready var panel: PanelContainer = $Contents/Core_components/Panel/Panel
@onready var viewport_size = get_viewport().get_visible_rect().size
@onready var window_storage: Node = $Contents/Window_storage
@onready var popup_storage: CanvasLayer = $Popups/CanvasLayer

var vfx_status: bool = true

var default_vfx_shader = preload("res://resources/shaders/shader_crt.tres")

func _ready() -> void:
	audioplayer.play()
	update_time()
	connect_to_corec()
	canvas_layer.show()
	vfx_node.material = default_vfx_shader
	print(Corec.Database["class_data"][1][1]["title"] + "Testing database")
	print(Corec.Database["class_data"][1][1]["text"] + "Testing database")

func _process(delta: float) -> void:
	if Corec.is_in_event == true:
		pass

#region Callable features

func spawn_window(window_path: String, window_pos: Vector2):
	var scene = load(window_path)
	var destination_node = window_storage
	if destination_node:
		var new_window = scene.instantiate()
		destination_node.add_child(new_window)
		new_window.position = window_pos
		new_window.show()
		new_window.is_instance_type = true
		print("A window was spawned via corec!")

func spawn_popup(popup_text: String, popup_name: String, has_pwd_query: bool):
	var scene = load("res://resources/scenes/core/Popup dialogue/popup.scn")
	var destination_node = popup_storage
	if destination_node:
		var popup = scene.instantiate()
		destination_node.add_child(popup)
		popup.show()
		popup.window_name = popup_name
		popup.window_text = popup_text
		popup.has_pwd_query = has_pwd_query
		popup.configure_popup()
		print("A popup was spawned via corec!")

func spawn_file_dialog():
	var destination_node = popup_storage
	if destination_node:
		var window = FileDialog.new()
		destination_node.add_child(window)
		window.filters = ["*.png", "*.jpeg"]
		window.show()
		window.access = FileDialog.ACCESS_FILESYSTEM
		window.file_mode = FileDialog.FILE_MODE_OPEN_FILE

		#window.position = Vector2(viewport_size.x / 2 - window.size.x/2, viewport_size.y / 2 - window.size.y/2 + 40)
		window.position = Vector2(102, 184)
		window.use_native_dialog = true
#func spawn_file_dialog():
	#$Popups/CanvasLayer/FileDialog.show()
	#print("A file dialog was spawned via corec!")

func change_panel_colors(color: Color):
	var existing_stylebox = panel.get_theme_stylebox("panel")
	if existing_stylebox:
		var new_stylebox = existing_stylebox.duplicate()
		new_stylebox.bg_color = color
		panel.add_theme_stylebox_override("panel", new_stylebox)

func change_wallpaper(path: String):
	var img = Image.new()
	var err = img.load(path)
	if err == OK:
		var texture = ImageTexture.create_from_image(img)
		background.texture = texture
	else:
		print("Failed to load image:", path)

func notifications_vos():
	pass

func change_background_music(audio:String):
	audioplayer.stream = load(audio)
	audioplayer.play()

func change_vfx_shader(shader: String):
	vfx_node.material = load(shader)

func switch_vfx_status():
	vfx_status = !vfx_status
	if vfx_status == true:
		canvas_layer.show()
	else:
		canvas_layer.hide()

func trigger_evx():
	vfx_node.material = load("res://resources/shaders/vignette.tres")
	Corec.spawn_popup("Auth required", "insert passcode", true)

func stop_evx():
	if Corec.is_in_event:
		vfx_node.material = default_vfx_shader
		for popup in popup_storage.get_children():
			popup.queue_free()

var music_status: bool = true

func switch_background_music():
	music_status = !music_status
	if !music_status:
		audioplayer.stop()
	else:
		audioplayer.play()

#endregion

#region Core components

#region Connect to Corec

func connect_to_corec():
	Corec.connect("change_wallpaper_signal", change_wallpaper)
	Corec.connect("change_background_music_signal", change_background_music)
	Corec.connect("switch_vfx_status_signal", switch_vfx_status)
	Corec.connect("change_vfx_shader_signal", change_vfx_shader)
	Corec.connect("trigger_event_x", trigger_evx)
	Corec.connect("interrupt_event_x", stop_evx)
	Corec.connect("change_panel_colors_signal", change_panel_colors)
	Corec.connect("spawn_window_signal", spawn_window)
	Corec.connect("spawn_popup_signal", spawn_popup)
	Corec.connect("spawn_file_dialog_signal", spawn_file_dialog)
	Corec.connect("switch_background_music_signal", switch_background_music)

#endregion

#region Time manager

@onready var date_label: Label = $Contents/Core_components/Panel/Time_manager/Date_label
@onready var time_label: Label = $Contents/Core_components/Panel/Time_manager/Time_label

func update_time() -> void:
	var date_dict: Dictionary = Time.get_datetime_dict_from_system()
	time_label.text = "%02d:%02d" % [date_dict.hour, date_dict.minute]
	date_label.text = "%02d/%02d/%d" % [date_dict.day, date_dict.month, date_dict.year]

func _on_time_update_timer_timeout() -> void:
	update_time()
	print("time updated!")

#endregion

#endregion
