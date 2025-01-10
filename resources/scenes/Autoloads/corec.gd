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

signal change_wallpaper_signal(texture)
signal change_background_music_signal(audio)
signal switch_background_music_signal
signal change_vfx_shader_signal(shader)
signal switch_vfx_status_signal
signal change_panel_colors_signal(color: Color)
signal spawn_window_signal(path_to_window: String, window_position: Vector2)
signal spawn_popup_signal(popup_title: String, popup_text: String, has_pwd_query: bool)
signal spawn_file_dialog_signal
signal trigger_event_x
signal interrupt_event_x

var is_in_splash: bool = false
var is_in_event: bool = false

func _ready() -> void:
	#Desktop_vos.connect("file_selected", on_file_selected)
	pass

func on_file_selected():
	pass

func change_wallpaper(texture: String):
	emit_signal("change_wallpaper_signal", texture)
	print("CorecCW")

func change_vfx_shader(shader: String):
	emit_signal("change_vfx_shader_signal", shader)
	print("CorecCVS")

func change_panel_colors(color: Color = Color(27, 33, 48, 255)):
	emit_signal("change_panel_colors_signal", color)

func change_background_music(audio: String):
	emit_signal("change_background_music_signal", audio)
	print("CorecCBM")

func switch_background_music():
	emit_signal("switch_background_music_signal")

func spawn_window(path_to_window: String, window_position: Vector2 = Vector2(0, 80)):
	emit_signal("spawn_window_signal", path_to_window, window_position)

func spawn_popup(popup_title: String = "Warning", popup_text: String = "Test", has_pwd_query: bool = false):
	emit_signal("spawn_popup_signal", popup_title, popup_text, has_pwd_query)

func spawn_file_dialog():
	emit_signal("spawn_file_dialog_signal")

#func start_event(shader: String = "res://resources/shaders/vignette.tres", background_image: String = "res://resources/sprites/background_unaligned.png", other_parameter: String = ""):
	#pass

func switch_vfx_status():
	switch_vfx_status_signal.emit()
	print("CorecSVS")

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("trigger_event_x_action") and is_in_splash == false:
		if is_in_event == true:
			interrupt_event_x.emit()
			is_in_event = false
		else:
			trigger_event_x.emit()
			is_in_event = true
			print("Triggered event X")

func stop_event_x():
	interrupt_event_x.emit()

var Database: Dictionary = {
	"class_data": {
		1: {
			"Total aulas": 7,
			1: {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			2: {
				"title": "Ponto, linha e plano",
				"text": "Vimos sobre o conceito de linha. Analisamos algumas obras que utilizaram apenas linhas em sua composição.\nA linha é a trajetória de um ponto em movimento, tendo comprimento, mas sem largura.\nEla é considerada um rastro invisível e representa uma tensão ativa, contrastando com a calma do ponto fixo.\n\nPlanos\nVimos sobre o conceito de planos.\nO plano é formado pela trajetória de uma linha em movimento, possuindo comprimento e largura, mas sem espessura.\nEle é delimitado por linhas e é responsável por definir os limites externos de um volume.\n\nLuz e Sombra\nVimos sobre a relação entre luz e sombra.\nA linha é o elemento que define o formato, enquanto a sombra revela a forma tridimensional dos objetos.\nA iluminação pode guiar a atenção de forma seletiva, destacando objetos sem depender de tamanho, cor ou posição central.\nUm exemplo disso foi a observação de uma cena em que a luz parecia emanar de um livro que Maria lê, iluminando a criança e projetando a sombra ampliada de José.\n\nAtividade Prática\nFizemos uma atividade prática sobre degradê utilizando linhas.\nO exercício consistiu em criar linhas mais espaçadas no início e gradualmente torná-las mais próximas, cruzando-as para gerar um efeito mais escuro.\nEssa técnica foi usada para simular diferentes intensidades de luz e sombra.",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			3: {
				"title": "Grafismo indígena, povos Yanomami, arte indígena.",
				"text": "Atividades desenvolvidas em sala:\nVimos sobre o grafismo indígena, com foco especial nos Yanomami e seus grafismos.\nGrafismo Indígena\nO grafismo indígena é caracterizado pelo uso de linhas, zigue-zagues, espirais, triângulos e losangos repetidos. Esses desenhos são inspirados em animais, plantas e fenômenos naturais. Eles representam mitos, lendas, crenças e rituais, e cada etnia possui seu próprio estilo de grafismo, refletindo sua identidade cultural.\nYanomami\nOs Yanomami são habitantes da Amazônia, vivendo entre o Brasil e a Venezuela. Suas pinturas são usadas em rituais, cerimônias e caçadas, utilizando tintas naturais como o urucum (vermelho) e o genipapo (preto). Eles aplicam padrões geométricos e abstratos no corpo para expressar proteção espiritual, força e status. Cada grafismo tem um significado profundo, podendo representar espíritos da floresta, animais ou proteção.\nAtividade\nRealizamos uma atividade onde desenhamos um grafismo indígena que vimos na visita técnica ao museu indígena. Eu escolhi criar uma máscara típica dos indígenas, usada em rituais e cerimônias, incorporando os elementos que aprendemos sobre os grafismos.",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			4: {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			5: {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			6: {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			7: {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			}
		},
		2: {
			"Total aulas": 7,
			1: {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			2: {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			3: {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			4: {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			5: {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			6: {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			7: {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			}
		},
		3: {
			"Total aulas": 7,
			1: {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			2: {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			3: {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			4: {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			5: {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			6: {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			7: {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			}
		},
		4: {
			"Total aulas": 7,
			1: {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			2: {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			3: {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			4: {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			5: {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			6: {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			7: {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			}
		},
		"personalworks": {
			1: {
				"title": "Aula 1 Title",
				"text": "Aula 1 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			2: {
				"title": "Aula 2 Title",
				"text": "Aula 2 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			3: {
				"title": "Aula 3 Title",
				"text": "Aula 3 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			4: {
				"title": "Aula 4 Title",
				"text": "Aula 4 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			5: {
				"title": "Aula 5 Title",
				"text": "Aula 5 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			6: {
				"title": "Aula 6 Title",
				"text": "Aula 6 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			},
			7: {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text",
				"images": {
					1: "res://resources/sprites/arrow.png",
					2: "res://resources/sprites/arrow.png"
					}
			}
		}
	}
}
