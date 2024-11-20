@icon("res://resources/sprites/window_icon.png")
extends Panel

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

# WARNING I KNOW WHAT YOU ARE DOING, YOU LITTLE INSIGNIFICANT FUCK. STOP SNOOPING AROUND THE AUTHENTICATOR CODE.
# DANGER YOU DESERVE TO BE CRUSHED BY A MANGO TRUCK'S WHEELS ON A SUNDAY AFTERNNOON
# INFO Thanks :3

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

var is_maximized: bool
var unmaximized_position: Vector2
var old_unmaximized_size: Vector2

@export_category("Window properties")
@export var is_visible: bool
@export var can_drag: bool
@export var can_maximize: bool
@export var can_close: bool
@export var can_resize: bool
@export var is_instance_type: bool

func _ready() -> void:
	if is_visible:
		self.show()
	else:
		self.hide()
	incorrect.visible = false

func _process(_delta: float) -> void:
	if is_dragging and can_drag:
		global_position = Windowz.handle_dragging(start_drag_position, mouse_start_drag_position, get_global_mouse_position())
		global_position = Windowz.clamp_window_inside_viewport(global_position, size, get_viewport().get_visible_rect().size, 3)
	if easter == false and swearing == false:
		incorrect.text = "!!Senha incorreta!!"

func _on_close_pressed() -> void:
	get_tree().call_group("folders", "window_state")
	if is_instance_type:
		queue_free()
	else:
		Windowz.close_window(self, close_audio)

func _on_draghandle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and is_maximized == false:
		if event.is_pressed():
			is_dragging = true
			start_drag_position = global_position
			mouse_start_drag_position = get_global_mouse_position()
		else:
			is_dragging = false


func _on_maximize_pressed() -> void:
	if can_maximize:
		if is_maximized:
			Windowz.restore_window(self, unmaximized_position, old_unmaximized_size)
		else:
			unmaximized_position = global_position
			old_unmaximized_size = size
			Windowz.maximize_window(self, unmaximized_position, old_unmaximized_size)
		is_maximized = !is_maximized

# --- Authenticator Logic ---

@onready var incorrect: Label = $INCORRECT
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit
@onready var timer: Timer = $Timer
@onready var wrong: AudioStreamPlayer = $INCORRECT/wrong
@onready var close_audio: AudioStreamPlayer = $close_audio
@onready var labobar: AudioStreamPlayer = $"../../../labo"
@onready var timer_incorrect: Timer = $INCORRECT/Timer

var easter: bool
var swearing: bool
var can_play: bool = true

signal disablebk

func _on_line_edit_text_submitted(_new_text: String) -> void:
	verify()

func _on_confirm_pressed() -> void:
	verify()

func verify():
	var user_input = line_edit.text
	if easter == false and can_play == true:
		match user_input:
			"cubigor":
				authenticate()
			"max9th":
				authenticate()
			"nightcity":
				authenticate()
			"labobarco":
				line_edit.text = ""
				labobar.play()
				easter = true
				disablebk.emit()
			"deziangle":
				authenticate()
			"fuck":
				swears()
			"no u":
				swears()
			"bitch":
				swears()
			_:
				incorrect.visible = true
				timer.start()
				line_edit.text = ""
				if can_play == true:
					wrong.play()
				timer_incorrect.start()
				line_edit.editable = false
				can_play = false
	elif easter == true:
		incorrect.text = "!!IT'S EASTER ALREADY!!"
		incorrect.visible = true
		timer.start()
		wrong.play()

func authenticate():
	var user_input = line_edit.text
	visible = false
	get_tree().call_group("authentication", "_on_authenticated" + "_" + str(user_input))
	easter = true
	line_edit.text = ""

func _on_mainmenu_stop() -> void:
	easter = false

func swears():
	swearing = true
	incorrect.text = "!!EW MANO!!"
	incorrect.visible = true
	timer.start()
	line_edit.text = ""
	wrong.play()

func _on_timer_timeout() -> void:
	incorrect.visible = false
	swearing = false

func _on_timer_incorrect_timeout() -> void:
	line_edit.editable = true
	can_play = true
