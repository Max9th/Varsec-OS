@icon("res://resources/sprites/window_icon.png")
extends Panel

@onready var maximize: Button = %maximize
@onready var close: Button = %close
@onready var close_audio: AudioStreamPlayer = $close_audio

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

var is_maximized: bool
var unmaximized_position: Vector2
var old_unmaximized_size: Vector2

var start_size: Vector2
var is_resizing: bool = false
const SCALE_FACTOR: float = 3
const MAX_WIDTH: float = 384
const MAX_HEIGHT: float = 216

@export_category("Window properties")
@export var is_visible: bool
@export var can_drag: bool
@export var can_maximize: bool
@export var can_close: bool
@export var can_resize: bool


func _ready() -> void:
	if is_visible:
		self.show()
	else:
		self.hide()
	hide_all_aulas()
	select_somethin.show()

func _process(_delta: float) -> void:
	if is_dragging and can_drag:
		global_position = Windowz.handle_dragging(start_drag_position, mouse_start_drag_position, get_global_mouse_position())
		global_position = Windowz.clamp_window_inside_viewport(global_position, size, get_viewport().get_visible_rect().size, 3)
	if is_resizing and can_resize:
		var mouse_position = get_global_mouse_position()
		if Input.is_key_pressed(KEY_SHIFT):
			Windowz.handle_aspect_ratio_resize(self, mouse_position, start_size, mouse_start_drag_position, 3)
		else:
			Windowz.handle_free_resize(self, mouse_position, start_size, mouse_start_drag_position, 3)
		if size.x > MAX_WIDTH:
			size.x = MAX_WIDTH
		if size.y > MAX_HEIGHT:
			size.y = MAX_HEIGHT

func _on_close_pressed() -> void:
	if can_close:
		Windowz.close_window(self, close_audio)

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and is_maximized == false:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false

func _on_resizehandle_gui_input(event: InputEvent) -> void:
	if can_resize and !is_maximized:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_resizing = true
				mouse_start_drag_position = get_global_mouse_position()
				start_size = size
			else:
				is_resizing = false

func _on_maximize_pressed() -> void:
	if can_maximize:
		if is_maximized:
			Windowz.restore_window(self, unmaximized_position, old_unmaximized_size)
		else:
			unmaximized_position = global_position
			old_unmaximized_size = size
			Windowz.maximize_window(self, unmaximized_position, old_unmaximized_size)
		is_maximized = !is_maximized

func _on_aulas_window_selected() -> void:
	visible = true

# --- Button manager ---

@onready var select_class: VBoxContainer = $sidebarcontainer/sidebar/select_class
@onready var select_bim: VBoxContainer = $sidebarcontainer/sidebar/select_bim
@onready var recentes: VBoxContainer = $sidebarcontainer/sidebar/recentes
@onready var go_back: VBoxContainer = $sidebarcontainer/sidebar/go_back
@onready var select_somethin: Control = $contentcontainer/contents/select_somethin
@onready var not_ready: Control = $contentcontainer/contents/not_ready
@onready var welcome: Control = $contentcontainer/contents/welcome
@onready var aula_6: Button = $sidebarcontainer/sidebar/select_class/aula6
@onready var changelog: Control = $contentcontainer/contents/changelog

@onready var aulas_umbim: Array = [
$"contentcontainer/contents/1bim/aula1"
]

@onready var aulas_doisbim: Array = [
$"contentcontainer/contents/2bim/aula1",
$"contentcontainer/contents/2bim/aula2",
$"contentcontainer/contents/2bim/aula3",
$"contentcontainer/contents/2bim/aula4",
$"contentcontainer/contents/2bim/aula5"
]

@onready var aulas_tresbim: Array = [
$"contentcontainer/contents/3bim/aula1"
]

@onready var aulas_quatrobim: Array = [
$contentcontainer/contents/not_ready
]

var is_menu_active: bool
var current_bim: int = 0

func hide_all_aulas() -> void:
	for aula in aulas_umbim:
		aula.hide()
	for aula in aulas_doisbim:
		aula.hide()
	for aula in aulas_tresbim:
		aula.hide()
	for aula in aulas_quatrobim:
		aula.hide()
	not_ready.hide()

func show_aula_umbim(index: int) -> void:
	hide_all_aulas()
	if index >= 0 and index < aulas_umbim.size():
		aulas_umbim[index].visible = true

func show_aula_doisbim(index: int) -> void:
	hide_all_aulas()
	if index >= 0 and index < aulas_doisbim.size():
		aulas_doisbim[index].visible = true

func show_aula_tresbim(index: int) -> void:
	hide_all_aulas()
	if index >= 0 and index < aulas_tresbim.size():
		aulas_tresbim[index].visible = true

func show_aula_quatrobim(index: int) -> void:
	hide_all_aulas()
	if index >= 0 and index < aulas_quatrobim.size():
		aulas_quatrobim[index].visible = true

func _on_bim_1_pressed() -> void:
	if !is_menu_active:
		is_menu_active = true
		current_bim = 1
		select_class.show()
		select_bim.hide()

func _on_bim_2_pressed() -> void:
	if !is_menu_active:
		is_menu_active = true
		select_class.show()
		select_bim.hide()
		current_bim = 2
		aula_6.hide()

func _on_bim_3_pressed() -> void:
	if !is_menu_active:
		is_menu_active = true
		select_bim.hide()
		select_class.show()
		current_bim = 3

func _on_bim_4_pressed() -> void:
	if !is_menu_active:
		is_menu_active = true
		select_bim.hide()
		select_class.show()
		current_bim = 4

func _on_aula_pressed(aula: int) -> void:
	is_menu_active = true
	select_somethin.hide()
	match current_bim:
		1:
			show_aula_umbim(aula)
		2:
			show_aula_doisbim(aula)
		3:
			show_aula_tresbim(aula)
		4:
			show_aula_quatrobim(aula)
		_:
			print("holy moly, how did ya do that shit?")

func _on_aula_1_pressed() -> void:
	_on_aula_pressed(0)

func _on_aula_2_pressed() -> void:
	_on_aula_pressed(1)

func _on_aula_3_pressed() -> void:
	_on_aula_pressed(2)

func _on_aula_4_pressed() -> void:
	_on_aula_pressed(3)

func _on_aula_5_pressed() -> void:
	_on_aula_pressed(4)

func _on_aula_6_pressed() -> void:
	_on_aula_pressed(5)

func _on_personal_pressed() -> void:
	if !is_menu_active:
		not_ready_yet()
		is_menu_active = true

func _on_welcome_pressed() -> void:
	welcome.show()
	hide_all_aulas()
	is_menu_active = true
	backtrack()

func _on_changelog_pressed() -> void:
	hide_all_aulas()
	is_menu_active = true
	welcome.hide()
	backtrack()
	changelog.show()

func _on_back_pressed() -> void:
	is_menu_active = false
	go_back.hide()
	not_ready.hide()
	welcome.hide()
	changelog.hide()
	hide_all_aulas()
	select_somethin.show()
	select_bim.show()
	current_bim = 0

func _on_back_classes_bim1_pressed() -> void:
	is_menu_active = false
	select_class.hide()
	select_bim.show()
	welcome.hide()
	changelog.hide()
	hide_all_aulas()
	select_somethin.show()
	current_bim = 0
	aula_6.show()

func not_ready_yet():
	go_back.show()
	select_bim.hide()
	select_class.hide()
	select_somethin.hide()
	hide_all_aulas()
	not_ready.show()

func backtrack():
	go_back.show()
	select_bim.hide()
	select_class.hide()
	select_somethin.hide()
	hide_all_aulas()


func _on_main_scene_welcome_display() -> void:
	welcome.show()
	hide_all_aulas()
	is_menu_active = true
	backtrack()
	if !is_maximized:
		unmaximized_position = global_position
		old_unmaximized_size = size
		Windowz.maximize_window(self, unmaximized_position, old_unmaximized_size)
		is_maximized = true
