@icon("uid://ba6ovj2sh64g3")
class_name Desktop_vos
extends Node

@onready var background: TextureRect = $Contents/Core_components/Background
@onready var canvas_layer: CanvasLayer = $vfx/CanvasLayer
@onready var vfx_node: ColorRect = $vfx/CanvasLayer/ColorRect
@onready var panel: PanelContainer = $Contents/Core_components/Panel/Panel
@onready var viewport_size = get_viewport().get_visible_rect().size
@onready var window_storage: Node = $Contents/Window_storage
@onready var popup_storage: CanvasLayer = $Popups/CanvasLayer
@onready var os_billboards: Control = $Contents/Core_components/Os_billboards
@onready var _3d_bk: SubViewport = $"Contents/Core_components/3d_bk/3d_bk"
@onready var notification_box := $Contents/Others/NotificationBoxPivot
@onready var notification_label: Label = $Contents/Others/NotificationBoxPivot/notification_box/NotificationLabel
@onready var notification_timer: Timer = $Contents/Others/NotificationBoxPivot/notification_box/NotificationTimer

var vfx_status: bool = true

#region Connect to Corec

func connect_to_corec():
	Corec.connect("change_wallpaper_signal", change_wallpaper,)
	Corec.connect("switch_vfx_status_signal", switch_vfx_status)
	Corec.connect("change_vfx_shader_signal", change_vfx_shader)
	Corec.connect("change_panel_colors_signal", change_panel_colors)
	Corec.connect("spawn_window_signal", spawn_window)
	Corec.connect("spawn_popup_signal", spawn_popup)
	Corec.connect("spawn_file_dialog_signal", spawn_file_dialog)
	Corec.connect("hide_billboards_signal", hide_billboards)
	Corec.connect("send_notification_signal", send_notification)
	Corec.connect("clear_popups", clear_popups)
	Corec.connect("clear_windows", clear_windows)

#endregion

func _ready() -> void:
	#audioplayer.play()
	update_time()
	connect_to_corec()
	canvas_layer.show()
	change_vfx_shader()
	Corec.change_background_music()
	Corec.stop_secondary_track()
	Corec.play_secondary_track("res://Files/audio/The fire is gone.mp3")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx_1"), 0)
	#print(Corec.Database["class_data"][1][1]["title"] + "Testing database")
	#print(Corec.Database["class_data"][1][1]["text"] + "Testing database")

func _process(_delta: float) -> void:
	if Corec.is_in_event == true:
		pass

#region Callable features

func spawn_window(window_path: StringName, window_pos: Vector2):
	var scene = load(window_path)
	var destination_node = window_storage
	if destination_node:
		print(str(scene))
		var new_window = scene.instantiate()
		destination_node.add_child(new_window)
		new_window.position = window_pos
		new_window.show()
		new_window.is_instance_type = true

func spawn_popup(popup_text: StringName, popup_name: StringName, has_pwd_query: bool):
	if popup_storage:
		var popup: popup_window_vos = load(Corec.popup_scene).instantiate()
		popup.show_window = true
		popup.is_instance_type = true
		popup.can_close = true
		popup.show()
		popup.window_name_label.text = popup_name
		popup.popup_text_label.text = popup_text
		popup.has_pwd_query = has_pwd_query
		popup_storage.add_child(popup)

func spawn_file_dialog():
	if popup_storage:
		var window = FileDialog.new()
		popup_storage.add_child(window)
		window.filters = ["*.png", "*.jpeg"]
		window.show()
		window.access = FileDialog.ACCESS_FILESYSTEM
		window.file_mode = FileDialog.FILE_MODE_OPEN_FILE

		#window.position = Vector2(viewport_size.x / 2 - window.size.x/2, viewport_size.y / 2 - window.size.y/2 + 40)
		window.position = Vector2(102, 184)
		window.use_native_dialog = false
#func spawn_file_dialog():
	#$Popups/CanvasLayer/FileDialog.show()
	#print("A file dialog was spawned via corec!")

func change_panel_colors(color: Color):
	var existing_stylebox = panel.get_theme_stylebox("panel")
	if existing_stylebox:
		var new_stylebox = existing_stylebox.duplicate()
		new_stylebox.bg_color = color
		panel.add_theme_stylebox_override("panel", new_stylebox)

var default_background_image = preload("uid://cmcpsmaw4gejf")
func change_wallpaper(path: StringName, is_3d: bool = false, path_to_3d_scene: StringName = &"uid://ctm4fp4tnsvm6"):
	if not path.is_empty():
		background.texture = load(path)
	else:
		print("Failed to load image:", path + " Loading default.")
		background.texture = default_background_image
	if is_3d:
		background.hide()
		for child in _3d_bk.get_children():
			child.queue_free()
		_3d_bk.add_child(load(path_to_3d_scene).instantiate())
	else:
		background.show()


func send_notification(content: StringName):
	notification_label.text = content
	var tween = create_tween()
	var target_position = Vector2(576 , 160)
	tween.tween_property(notification_box, "position", target_position, .2)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	notification_timer.start()

func change_vfx_shader(path_to_shader: StringName = &"uid://c7vnw4dnik7g3"):
	if !path_to_shader.is_empty():
		vfx_node.material = load(path_to_shader)

func switch_vfx_status():
	vfx_status = !vfx_status
	if vfx_status == true:
		canvas_layer.show()
	else:
		canvas_layer.hide()

var music_status: bool = true

func clear_popups():
	for popup in popup_storage.get_children():
		if popup is popup_window_vos:
			popup.close_window()

func clear_windows():
	for window in window_storage.get_children():
		if window is window_vos:
			window.close_window()

var billboard_status: bool = true

func hide_billboards():
	billboard_status = !billboard_status
	if !billboard_status:
		os_billboards.hide()
	else:
		os_billboards.show()

#endregion

#region Core components

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


func _on_notification_timer_timeout() -> void:
	var tween = create_tween()
	var target_position = Vector2(576, -48)
	tween.tween_property(notification_box, "position", target_position, .2)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
