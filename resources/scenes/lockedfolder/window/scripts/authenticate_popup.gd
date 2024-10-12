extends Panel

@onready var incorrect: Label = $INCORRECT
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit
@onready var timer: Timer = $Timer
@onready var wrong: AudioStreamPlayer = $INCORRECT/wrong
@onready var close_audio: AudioStreamPlayer = $close_audio
@onready var labobar: AudioStreamPlayer = $"../../../labo"

var is_dragging: bool
var start_drag_position: Vector2
var mouse_start_drag_position: Vector2

var is_maximized: bool
var old_unmaximized_position: Vector2
var old_unmaximized_size: Vector2

@export var is_visible: bool
@export var can_drag: bool
@export var can_maximize: bool
@export var can_close: bool

# ---
var easter: bool
var swearing: bool
# ---

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
			Windowz.restore_window(self, old_unmaximized_position, old_unmaximized_size)
		else:
			old_unmaximized_position = global_position
			old_unmaximized_size = size
			Windowz.maximize_window(self, old_unmaximized_position, old_unmaximized_size)
		is_maximized = !is_maximized

# --- Authenticator Logic ---

func _on_line_edit_text_submitted(_new_text: String) -> void:
	authenticate()

func _on_confirm_pressed() -> void:
	authenticate()
	
func authenticate():
	var user_input = line_edit.text
	if easter == false:
		match user_input:
			"cubigor":
				authenticated()
			"max9th":
				authenticated()
			"lies":
				authenticated()
			"fourtyfive":
				authenticated()
			"labobarco":
				labo()
			"ass":
				swears()
			"merda":
				swears()
			"penis":
				swears()
			"rola":
				swears()
			"pussy":
				swears()
			"xereca":
				swears()
			"pika":
				swears()
			"porra":
				swears()
			"xota":
				swears()
			"caralho":
				swears()
			"xereca":
				swears()
			"deltong":
				gay()
			_:
				incorrect.visible = true
				timer.start()
				line_edit.text = ""
				wrong.play()
	elif easter == true:
		incorrect.text = "!!IT'S EASTER ALREADY!!"
		incorrect.visible = true
		timer.start()
		wrong.play()

func authenticated():
	var user_input = line_edit.text
	visible = false
	get_tree().call_group("authentication", "_on_authenticated" + "_" + str(user_input))
	easter = true

func _on_mainmenu_stop() -> void:
	easter = false

func swears():
	swearing = true
	incorrect.text = "!!EW MANO!!"
	incorrect.visible = true
	timer.start()
	line_edit.text = ""
	wrong.play()

func gay():
	swearing = true
	var choose: int = randi() % 2
	if choose == 1:
		incorrect.text = "<3 gotta luv it"
	else:
		incorrect.text = "HACKER FILHO DE UMA INFELIZ, DESGRAÇADO"
	incorrect.visible = true
	timer.start()
	line_edit.text = ""
	wrong.play()

func _on_timer_timeout() -> void:
	incorrect.visible = false
	swearing = false
signal disablebk

func labo():
	line_edit.text = ""
	labobar.play()
	easter = true
	disablebk.emit()
