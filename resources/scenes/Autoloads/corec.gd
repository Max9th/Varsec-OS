extends Node

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

# Max9th

	#',,,,.  'cccccc, .cccccc;
 #,,,,,,,, ,cccccc; 'cccccc:
 #.,,,,,,. ,cccccc; 'cccccc:

 #.,,;;,,. .,,,,,,.
 #;cccccc, ,cccccc;
 #;cccccc, ,cccccc;
 #'cccccc. .cccccc'

 #;cccccc, ,cccccc; 'cccccc:
 #;cccccc, ,cccccc; 'cccccc:
 #;cccccc, ,cccccc; 'cccccc:

 #,cccccc, 'cccccc,
 #;cccccc, ,cccccc;
 #;cccccc, ,cccccc;

# Instituto Federal do Goiás

											 #..          ..
									#';:llll,        'llllc;'
								 #.llllllll,      .llllllll,
								 #.lllllllllcccccclllllllll.
								 #'llllllllllllllllllllllll,
			#.;,.    .,cllllllllllllllllllllllllllc,.    .,;.
		 #,lllll:,cllllllllllllllllllllllllllllllllc,:lllll;
	 #.cllllllllllllllllllllllllllllllllllllllllllllllllllc.
		#llllllllllllllllllllllllllllllllllllllllllllllllllll.
		 #:lllllllllllllllllllllllllllllllllllllllllllllllll
			#:llllllllldddlllllllllllllllllllllloddllllllllll
			#:llllllxXMWXXWXxllllllllllllllllxXWXXWMXklllllll
			#:lllllOMWo''''lWOllllldKKxlllllkWo''''lNM0llllll
			#:lllllNMk''''''xNlllllKMMNlllllXO''''''dMWllllll
			#:lllllxMNc'''':NklllllKMMNlllllxNc'''':XMkllllll
			#:llllllo0XX0O00ollllll0MMKlllllloO0O0KX0dlllllll
			#:llllllllllllllllllllllddlllllllllllllllllllllll
			#xkkxxddoollllllllllllllllllllllllllllllooddxxkkO
			#x00KKXXNMWllllllllx0000000000xllllllllXMNXXKK00O
			#;lllllllNMolllllllNMOkkkkkkkMWllllllllMWlllllllc
			 #lllllllKMXKKK00OOMWllllllllXM0O000KKXMXlllllll.
				#llllllldddxxkkkOOdlllllllldOOkkkxxdddlllllll
					#llllllllllllllllllllllllllllllllllllllll
						 #;llllllllllllllllllllllllllllllll:
									 #.llllllllllllllllllll.

#Corec - Comunication Core

# DANGER kind reminder for me to add a function that spawns popup windows

signal wallpaper_change(texture)
signal change_audio(audio)
signal cng_vfx_shader(shader)
signal vfx_switch
signal trigger_event_x
signal interrupt_event_x

var eventx_status: bool = false

func change_wallpaper(Tex: String):
	emit_signal("wallpaper_change", Tex)
	print("CorecCW")

func change_vfx_shader(shader):
	emit_signal("wallpaper_change", shader)
	print("CorecCVS")

func change_background_music(audio: String):
	emit_signal("change_audio", audio)
	print("CorecCBM")

func switch_vfx():
	vfx_switch.emit()
	print("CorecSV")

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("trigger_event_x_action"):
		trigger_event_x.emit()
		eventx_status = true
	print("Triggered event X")


func stop_event_x():
	interrupt_event_x.emit()

const Database: Dictionary = {
	"class_data": {
		"1bim": {
			"aula_1": {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text"
			},
			"aula_2": {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text"
			},
			"aula_3": {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text"
			},
			"aula_4": {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text"
			},
			"aula_5": {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text"
			},
			"aula_6": {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text"
			},
			"aula_7": {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text"
			}
		},
		"2bim": {
			"aula_1": {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text"
			},
			"aula_2": {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text"
			},
			"aula_3": {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text"
			},
			"aula_4": {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text"
			},
			"aula_5": {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text"
			},
			"aula_6": {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text"
			},
			"aula_7": {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text"
			}
		},
		"3bim": {
			"aula_1": {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text"
			},
			"aula_2": {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text"
			},
			"aula_3": {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text"
			},
			"aula_4": {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text"
			},
			"aula_5": {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text"
			},
			"aula_6": {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text"
			},
			"aula_7": {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text"
			}
		},
		"4bim": {
			"aula_1": {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text"
			},
			"aula_2": {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text"
			},
			"aula_3": {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text"
			},
			"aula_4": {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text"
			},
			"aula_5": {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text"
			},
			"aula_6": {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text"
			},
			"aula_7": {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text"
			}
		},
		"personalworks": {
			"aula_1": {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text"
			},
			"aula_2": {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text"
			},
			"aula_3": {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text"
			},
			"aula_4": {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text"
			},
			"aula_5": {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text"
			},
			"aula_6": {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text"
			},
			"aula_7": {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text"
			}
		}
	}
}
