extends Control

						  #:xkl..                  
						   #'kWMNd.                
				 #:lll,       .xMMWd.              
			 #.oXNMMMMWXK:     .xWMMWx.            
		   #.dNMMWOk;...,kd.    .NMMMMO.           
		  #.OMMWk'               ,NMMMMO           
		  #0MMWx   .okko.        .XMMMMNd          
		  #0MMx    0MMMMK         XMMMMMK          
		  #;KMx    :KWWK:       .oNMMMMMK          
		   #;0Wk                .NMMMMMMK          
			 #,O0:             .XMMMMMM0.          
			   #..           .lXMMMMMMNo           
						  #.oXMMMMMMMNl            
		  #:x:..       .'xkNMMMMMMMNo.             
		   #,OWXdoooooOWMMMMMMMMMNl.               
			 #'oxWWWMMMMMMMMWWKol.                 
				#...lxxxxxx'..                     

@onready var ambientsound: AudioStreamPlayer = $ambientsound
@onready var takecare: AudioStreamPlayer = $desktop/Folders/rightvboxcon/musicplayer/takecare

@onready var splash_screen: CanvasLayer = $splash_screen
@onready var background: TextureRect = $desktop/background

@onready var gay: TextureRect = $gay

@onready var time: Label = $desktop/panel/Panel/time
@onready var date: Label = $desktop/panel/Panel/date

@onready var sfx_button: Button = $desktop/panel/Panel/sfx_button
@onready var sfx_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/sfx_button_sprite

@onready var vfx: ColorRect = $vfx
@onready var vfx_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/vfx_button_sprite
@onready var panelpanel: Panel = $desktop/panel/Panel

@onready var power_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/Power_button_sprite
@onready var power_button: Button = $desktop/panel/Panel/power_button

@onready var windows: Control = $desktop/windows
@onready var personalworkswindow: Panel = $desktop/windows/personalworkswindow
@onready var class_manager_window: Panel = $desktop/windows/class_manager_window

@onready var easter_button: Button = $desktop/panel/Panel/easter_button
@onready var easter_button_sprite: TextureRect = $desktop/panel/Panel/HBoxContainer/easter_button_sprite

@onready var panel: Control = $desktop/panel
@onready var logopor: Label = $desktop/portfolio
@onready var authenticate_popup: Panel = $desktop/windows/authenticate_popup
@onready var nelixwindow: Panel = $desktop/windows/nelixwindow

@onready var play_nelix: TextureButton = $"desktop/Folders/rightvboxcon/play nelix"
@onready var musicplayer: TextureButton = $desktop/Folders/rightvboxcon/musicplayer
@onready var corrupted: TextureButton = $"desktop/Folders/rightvboxcon/h̴͉̋ò̸̜m̵̢͘ë̸̦ ̸̺͐s̶̘̀ẃ̷̙é̷͜e̵̻̓ṱ̷̏ ̵̞́h̴̝̀o̷̬͋m̶̠̐ḛ̶̍"

@export var all_windows_visible: bool 

var open_count: int = 0

var playaudio: bool = true
var easter: bool

signal stop

func _on_power_button_pressed() -> void:
	get_tree().quit()


func _ready() -> void:
	vfx.visible = true
	vfx_button_sprite.texture = load("res://resources/sprites/vfx.png")
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	easter_button_sprite.visible = false
	easter_button.disabled = true
	windows.visible = true
	corrupted.visible = false
	windows.position.x = 0
	update_time()
	if all_windows_visible:
		personalworkswindow.show()
		class_manager_window.show()
		nelixwindow.show()
		authenticate_popup.show()

func _process(_delta: float) -> void:
	if splash_screen.visible == false and ambientsound.playing == false and background.visible == true and playaudio == true and !easter:
		ambientsound.playing = true
		sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	elif ambientsound.playing == true and playaudio == false:
		sfx_button_sprite.texture = load("res://resources/sprites/disabledsfx.png")
		ambientsound.playing = false
	elif easter:
		ambientsound.stop()
		if takecare.playing:
			takecare.stop()

func _on_sfx_button_pressed() -> void:
	playaudio = !playaudio

func _on_cubigor_cubigorbk() -> void:
	easter_time()
	background.visible = false
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	gay.visible = false
	takecare.playing = false

func _on_lies_disablebk() -> void:
	easter_time()
	background.visible = false
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	gay.visible = false
	panel.visible = false
	play_nelix.visible = false
	musicplayer.visible = false
	corrupted.visible = true

func _on_labo_disablebk() -> void:
	easter_time()

func _on_fourtyfive_disablebk() -> void:
	background.texture = load("res://resources/sprites/45.png")
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	easter_time()
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")
	var stylebox = load("res://resources/scenes/Main_scene/Main_scene.tscn::StyleBoxFlat_yma61")
	if stylebox is StyleBoxFlat:
		stylebox.bg_color = Color(0.309, 0.352, 0.472)
		panelpanel.set("custom_styles/panel", stylebox)

func _on_gaytscn_disablebk() -> void:
	easter_time()
	background.visible = false
	sfx_button_sprite.texture = load("res://resources/sprites/sfx.png")


func _on_vfx_button_pressed() -> void:
	vfx.visible = !vfx.visible
	if vfx.visible == false:
		vfx_button_sprite.texture = load("res://resources/sprites/disabledvfx.png")
	else:
		vfx_button_sprite.texture = load("res://resources/sprites/vfx.png")

func easter_time():
	easter = !easter
	if easter:
		easter_button.disabled = false
		easter_button_sprite.visible = true
		logopor.visible = false
func _on_easter_button_pressed() -> void:
	background.visible = true
	background.texture = load("res://resources/sprites/bk.png")
	logopor.visible = true
	gay.visible = true
	stop.emit()
	easter = false
	easter_button.disabled = true
	easter_button_sprite.visible = false

func update_time() -> void:
	var date_dict: Dictionary = Time.get_datetime_dict_from_system()
	time.text = "%02d:%02d" % [date_dict.hour, date_dict.minute]
	date.text = "%02d/%02d/%d" % [date_dict.day, date_dict.month, date_dict.year]

func _on_timer_timeout() -> void:
	update_time()
