@icon("uid://dq3u5uprgstxv")
extends Node

			  #.,ldxkxdo:,..                          ..,:ldkkxdl;.
			  #'oKWMMNKOdc,.                          .'cdkKNMMWXd'
			  #'dNMXx;'...                              ...';dKMNk,
			  #'dXNk;                                        ,xXXx,
			  #.ckko'                                        .lkkl'
			   #.',..         .......        .......         ..,,.
						  #,d0NNNXNNN0o'  .lOXNXXNNNKx;.
						 #.cOWMN0k0NMWk;  'xWMW0kONMW0l.
						 #.c0WXl. .oNWO;  ,kNNd' .cKWKl.
						  #:kXk;   cOXx,  'dKOl.  ;kXOc.
						  #'coc'   ,lo:.  .;ol,.  'coc'.
					   #..',::;.   .;::,'',;:;'   .;::;'..
					  #.';ccc:,.   .,cc::::cc;.   .,:ccc:,.
						#......     ..........      .....
					  #,dOk:   .','    ckOl.   .,'.   ;xOx;.
					  #;xK0o.  .,;,.  .oKKd'   ';,.  .l0Kk:.
			   #.''..   ....           ....           ....    .''.
			  #.,cc,.                                        .,cc,.
			  #.cxOl'                                        .lxkl.
			  #'dXWXx;....                               ...,dKWNk,
			  #'dXMMMWX0dc,.                          .'cdOXWMMMNx,
			  #.'codxdol;'..                          ..';codxdoc,.

# ForgeWorks

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

#Core - Comunication Core

signal change_wallpaper_signal(texture, is_3d, path_to_3d_scene)
#signal change_background_music_signal(audio)
#signal switch_background_music_signal
signal change_vfx_shader_signal(shader)
signal switch_vfx_status_signal
signal change_panel_colors_signal(color: Color)
signal spawn_window_signal(path_to_window: String, window_position: Vector2)
signal spawn_popup_signal(popup_title: String, popup_text: String, has_pwd_query: bool)
signal spawn_file_dialog_signal
signal hide_billboards_signal
signal send_notification_signal(content: String)
signal clear_popups
signal clear_windows
signal event_started_signal
signal event_ended_signal

signal imported_database
signal exported_database

var is_in_splash: bool = false
var is_in_event: bool = false:
	set = hide_billboards
var music_status: bool = true
var audioplayer_primary = AudioStreamPlayer.new()
var audioplayer_secondary = AudioStreamPlayer.new()

const default_panel_color := Color("1b2130")
const crt_shader_uid := &"uid://c7vnw4dnik7g3"
const default_background_uid := &"uid://cmcpsmaw4gejf"
const default_3d_scene_uid := &"uid://ctm4fp4tnsvm6"
const default_audio_uid := &"uid://fm0ge4ls8qmc"
const default_secondary_track_uid := &"uid://itth0n1hb0dj"
const popup_scene_uid:= &"uid://gbtor40k4ppf"
const context_menu_uid: = &"uid://ofsorkmpwg8q"
const desktop_uid := &"uid://qs2b04s0sqis"

var opened_programs: Array = []
var program_ids: Array = []
var viewport_size: Vector2 = Vector2(1152, 648)
var panel_height: int = 80

@onready var viewport = get_viewport()

func hide_billboards(value):
	is_in_event = value
	hide_billboards_signal.emit()

func _ready() -> void:
	viewport.size_changed.connect(_on_viewport_size_changed)
	audioplayer_primary.name = "AudioPlayer_primary"
	add_child(audioplayer_primary)
	audioplayer_secondary.name = "AudioPlayer_secondary"
	add_child(audioplayer_secondary)
	audioplayer_secondary.bus = "sfx_1"

func generate_program_id():
	var new_id: int
	while true:
		new_id = randi()
		if new_id not in program_ids:
			break
	return new_id

func get_program_by_id(id: int):
	for program in opened_programs:
		if id == program.id:
			return program

func _on_viewport_size_changed():
	var size = viewport.get_visible_rect().size
	viewport_size = size

func define_panel_height(height: int):
	panel_height = height

#func detect_long_press():
	#pass
#
#func detect_double_click():
	#pass

func send_notification(content: String = "Test notification"):
	if !content.is_empty():
		emit_signal("send_notification_signal", content)

func change_wallpaper(path_to_texture: StringName = default_background_uid, is_3d: bool = false, path_to_3d_scene: StringName = default_3d_scene_uid):
	if !path_to_texture.is_empty():
		emit_signal("change_wallpaper_signal", path_to_texture, is_3d, path_to_3d_scene)
		print("CoreCHANGEWALLPAPER")

func change_vfx_shader(path_to_shader: StringName = crt_shader_uid):
	if !path_to_shader.is_empty():
		emit_signal("change_vfx_shader_signal", path_to_shader)
		print("CoreCHANGEVFXSHADER")

func change_panel_colors(color: Color = default_panel_color):
	emit_signal("change_panel_colors_signal", color)

func change_background_music(audio: StringName = default_audio_uid):
	if !audio.is_empty():
		audioplayer_primary.stream = load(audio)
		if audioplayer_primary.stream:
			audioplayer_primary.stream.loop = true
			audioplayer_primary.play()
		else:
			print("Error: Stream is invalid for audioplayer_primary")
		print("CoreCHANGEBACKGROUNDMUSIC")

func play_secondary_track(path_to_audio: StringName = default_secondary_track_uid, loop: bool = false):
	stop_secondary_track()
	if !path_to_audio.is_empty():
		audioplayer_secondary.stream = load(path_to_audio)
		audioplayer_secondary.play()
		if audioplayer_secondary.stream:
			audioplayer_secondary.stream.loop = true
		else:
			print("Error: Stream is invalid for audioplayer_secondary")
		print("CorePLAYSECONDARYTRACK")

func stop_secondary_track():
	audioplayer_secondary.stop()
	print("CoreSTOPSECONDARYTRACK")

func switch_background_music():
	music_status = !music_status
	if !music_status:
		audioplayer_primary.stop()
	else:
		audioplayer_primary.play()

func create_window(window_name: StringName = &"Lorem"):
	var window = window_vos.new()

func open_program(path_to_window: StringName = &"uid://itth0n1hb0dj", window_position: Vector2 = Vector2(0, 80)):
	if !path_to_window.is_empty():
		emit_signal("spawn_window_signal", path_to_window, window_position)
		print("CoreSPAWNWINDOW")

func spawn_popup(popup_title: StringName = "Test", popup_text: String = "Test", has_pwd_query: bool = false):
	clear_popups.emit()
	emit_signal("spawn_popup_signal", popup_title, popup_text, has_pwd_query)
	print("CoreSPAWNPOPUP")

func spawn_file_dialog():
	emit_signal("spawn_file_dialog_signal")
	print("CoreSPAWNFILEDIALOG")

func start_event(
	shader: StringName = crt_shader_uid,
	background_image: String = default_background_uid,
	background_music: String = default_secondary_track_uid,
	panel_color: Color = default_panel_color,
	has_3d_wallpaper: bool = false,
	_3d_bk_path: StringName = default_3d_scene_uid
):
	event_started_signal.emit()
	if not is_in_event:
		is_in_event = true
		play_secondary_track(background_music, true)
		change_panel_colors(panel_color)
		change_vfx_shader(shader)
		change_wallpaper(background_image, has_3d_wallpaper, _3d_bk_path)
	else:
		send_notification("Error: Can't activate even while in event")

	print("CoreSTARTEVENT")

func stop_event():
	event_ended_signal.emit()
	play_secondary_track("")
	change_panel_colors()
	change_vfx_shader()
	change_wallpaper()
	stop_secondary_track()
	is_in_event = false
	print("CoreSTOPEVENT")

func switch_vfx_status():
	switch_vfx_status_signal.emit()
	print("CoreSWITCHVFXSTATUS")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("trigger_event_x_action") and is_in_splash == false:
		if is_in_event == true:
			stop_event()
			clear_popups.emit()
		else:
			start_event("uid://cwuwsinbkkmii", "uid://cmcpsmaw4gejf", "uid://bqnj3h6bpdg57", Color(27, 33, 48, 255), true)
			spawn_popup("Insert passcode", "", true)
			clear_windows.emit() # TODO Revamp this based on opened_programs list
			print("Triggered Backspace log")

func export_database(path: String):
	if not path.ends_with(".json"):
		path += ".json"

	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(Database, "\t")
		file.store_string(json_string)
		file.close()
		print("Database exported to %s :D" % path)
		send_notification("Database exported to %s :D" % path)
		exported_database.emit()
	else:
		print(":c Failed to open file for writing: " + path)
		send_notification(":c Failed to open file for writing: " + path)

func import_database(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		print("Error opening file")
		send_notification("Error opening file")
		return

	var json_string = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_string)

	if error == OK:
		var data: Dictionary = json.data
		Database = data
		send_notification("Successfully imported Database from " + path)
		imported_database.emit()
		#if "class_data" in data:
			#print(data)
		#else:
			#print("Missing 'class_data' in JSON")
			#send_notification("Missing 'class_data' in JSON")
	else:
		print("Error parsing JSON: ", json.get_error_message())
		send_notification("Error parsing JSON: " + json.get_error_message())

var _bus_name: String
func fade_out_secondary_sfx(bus_name: String, target_volume, fade_duration):
	_bus_name = bus_name
	var current_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name))
	var tween = create_tween()
	tween.tween_method(Callable(self, "_set_bus_volume"), current_volume, target_volume, fade_duration)

func _set_bus_volume(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(_bus_name), volume)

@export var Database: Dictionary = {
	"class_data": {
#region First semester
		"1": {
			"total_classes": "6",
			"1": {
				"title": "Pontos e Pontilhismo",
				"text": "O pontilhismo é a arte de desenhar apenas com pontos.\nUm ponto pode representar o início e o fim de uma linha.\nPode também representar uma posição e/ou um cruzamento entre duas linhas.\nVale notar que toda linha é composta por diversos pontos.\nOs pontos são essenciais para a arte como um todo.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/pontilhismo.jpg",
					"2": ""
					}
			},
			"2": {
				"title": "Conceito de linhas, planos, luz e sombra",
				"text": "Atividades desenvolvidas em sala:\nVimos sobre os conceitos de linhas, planos, luz e sombra, além de analisarmos algumas obras que utilizaram esses elementos.\n\nLinha\nA linha é a trajetória de um ponto em movimento, tendo comprimento, mas sem largura.\nEla é considerada um rastro invisível, representando uma tensão ativa em contraste com a calma do ponto fixo.\n\nPlanos\nO plano é formado pela trajetória de uma linha em movimento, possuindo comprimento e largura, mas sem espessura.\nEle é delimitado por linhas e define os limites externos de um volume.\n\nLuz e sombra\nA linha define o formato, enquanto a sombra revela a forma tridimensional dos objetos.\nA iluminação guia a atenção de forma seletiva, destacando objetos sem depender de tamanho, cor ou posição central.\nObservamos uma cena em que a luz parecia emanar de um livro que Maria lia, iluminando a criança e projetando a sombra ampliada de José.\n\nAtividade\nRealizamos uma atividade prática de criação de um degradê utilizando linhas. A tarefa consistiu em desenhar linhas mais espaçadas no início e gradualmente torná-las mais próximas e cruzadas, gerando um efeito mais escuro.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/sobre-um-plano-so-podem-ser-feitas-imagens-duas-dimensoes-58d51308ee80b.webp",
					"2": ""
					}
			},
			"3": {
				"title": "Cores",
				"text": "Assunto tratado:\nCores primárias, secundárias e terciárias, cores quentes e frias.\n\nAtividades desenvolvidas em sala:\nVimos sobre as cores primárias, secundárias e terciárias, e o conceito de cores quentes e frias.\n\nCores primárias, secundárias e terciárias\nCores primárias são a base para criar outras cores: vermelho, verde e azul.\nCores secundárias são criadas pela mistura de duas cores primárias, resultando em cores como verde, laranja e roxo.\nCores terciárias são criadas pela mistura de uma cor primária com uma cor secundária, resultando em cores como azul-esverdeado, vermelho-alaranjado e amarelo-esverdeado.\n\nCores quentes e frias\nAs cores quentes (vermelho, laranja, amarelo) transmitem energia.\nAs cores frias (azul, verde, roxo) transmitem calma.\n\nAtividade\nRealizamos uma atividade prática de criação de um círculo cromático com as cores primárias, secundárias e terciárias, aplicando os conceitos aprendidos.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/timthumb.png",
					"2": ""
					}
			},
			"4": {
				"title": "Cores complementares e análogas",
				"text": "Atividades desenvolvidas em sala:\nVimos sobre as cores complementares e análogas e como essas cores interagem no círculo cromático.\n\nCores complementares e análogas\nCores complementares são aquelas que estão opostas no círculo cromático, criando contraste.\nCores análogas são aquelas que estão lado a lado no círculo cromático, criando harmonia.\n\nAtividade\nComplementamos a atividade anterior, incluindo as cores primárias e suas cores análogas.\nTambém realizamos uma obra utilizando pontos e linhas para juntar cores.\nAlém disso, tivemos uma atividade para casa, onde deveríamos criticar o trabalho de um colega, descrevendo-o e analisando-o.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/timthumb.png",
					"2": "res://Files/Sprites/classmanagerassets/rust-gold-8-32x.png"
					}
			},
			"5": {
				"title": "Trabalho bimestral: Arte com copos",
				"text": "Atividades desenvolvidas em sala:\nIniciamos o projeto bimestral de artes, com o professor apresentando uma obra de referência para guiar o processo.\nPrimeiro, decidimos qual desenho criar e optamos por um arco-íris, pois essa imagem permite o uso de várias cores, tornando a obra visualmente mais interessante.\nCriamos um modelo inicial para termos uma visão de como ficaria o desenho final.\nPara iniciar o desenho, utilizamos copos vazios, posicionando-os do centro até as extremidades para formar um arco o mais preciso possível. Em seguida, desenhamos as nuvens que serviriam como base para o arco-íris.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/atividade-5a.png",
					"2": ""
					}
			},
			"6": {
				"title": "Trabalho bimestral: Arte com copos",
				"text": "Atividades desenvolvidas em sala:\nFinalizamos o trabalho bimestral, com o professor fornecendo três cores primárias: vermelho, amarelo e azul.\nEnchemos os copos com água e adicionamos tinta, misturando as cores para criar novas tonalidades e tornar o arco-íris mais detalhado.\nTambém fizemos mais alguns detalhes ao redor do desenho, como nuvens e estrelas.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/atividade-5a.png",
					"2": "res://Files/Sprites/classmanagerassets/atividade-5b.jpg"
					}
			}
		},
#endregion
#region Second semester
		"2": {
			"total_classes": "5",
			"1": {
				"title": "Identidade cultural, povos originários, arte marajoara",
				"text": "Atividades desenvolvidas em sala:\nDesenho baseado em duas espécies de animais brasileiros fundidos em um único ser. Eu usei um morcego fruteiro e uma jararaca-de-alcatrazes.\nFalamos sobre a arte marajoara, os povos originários e a identidade cultural.\n\nArte Marajoara\nA arte marajoara foi criada pelo povo que vivia na Ilha de Marajó entre os anos 400 e 1400 d.C. Ela é mais conhecida pelas cerâmicas com formas geométricas e detalhes bem elaborados.\n\nPovos Originários\nOs povos indígenas no Brasil têm uma diversidade cultural e artística gigante. Eles produzem coisas como pinturas corporais, cerâmicas, cestaria e histórias mitológicas. A arte é super importante para rituais religiosos, se conectar com a natureza e manter viva a memória cultural.\n\nIdentidade Cultural\nA identidade cultural está ligada aos valores, tradições e crenças de cada grupo. Na arte, ela aparece através de símbolos, estilos e técnicas que são passados de geração em geração. Os povos usam a arte para mostrar como veem o mundo e registrar suas experiências.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/1271416569_4a3d19b1ff_b.jpg",
					"2": "res://Files/Sprites/classmanagerassets/1727438391663.jpg"
					}
			},
			"2": {
				"title": "Visíta técnica ao Museu dos Povos Indigenas",
				"text": "Atividades desenvolvidas em sala:\nMeus colegas foram ao museu dos povos indígenas, onde tiveram a oportunidade de conhecer diversas etnias e suas culturas. Eles observaram uma rica variedade de grafismos indígenas, tanto em cerâmicas quanto em máscaras e cestos.\n\nMáscaras Indígenas\nAs máscaras que eles viram, usadas em rituais e cerimônias, eram intrigantes. Cada uma possui sua própria simbologia e serve para representar espíritos ou personagens significativos nas tradições culturais.\n\nVasilhas de Cerâmica\nAs vasilhas de cerâmica que foram exibidas eram notáveis, com algumas apresentando desenhos ricos e detalhados, refletindo as tradições e a identidade cultural de cada povo.\n\nColar de Penas\nEles também viram colares feitos com penas, que são adornos tradicionais e têm um papel importante nas expressões culturais e espirituais dos indígenas.\n\nCestas Coloridas\nAs cestas que eles observaram eram de diversos tamanhos e formatos, confeccionadas com materiais vibrantes, evidenciando a habilidade e a criatividade dos artesãos indígenas.\n\nMadeira Esculpida\nOs colegas tiveram a oportunidade de ver esculturas em madeira que representavam animais, adornadas com desenhos que contam histórias e mostram a conexão dos indígenas com a natureza.\n\nMural com Grafismos\nPor fim, eles encontraram um mural desenhado no estilo do grafismo indígena, repleto de figuras de animais e formas geométricas. Esse mural destaca a biodiversidade e a profunda relação espiritual que os povos indígenas mantêm com o meio ambiente.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/aula_2d.jpeg",
					"2": "res://Files/Sprites/classmanagerassets/aula_2a.jpeg"
					}
			},
			"3": {
				"title": "Grafismo indígena, povos Yanomami, arte indígena",
				"text": "Atividades desenvolvidas em sala:\nVimos sobre o grafismo indígena, com foco especial nos Yanomami e seus grafismos.\n\nGrafismo Indígena\nO grafismo indígena é caracterizado pelo uso de linhas, zigue-zagues, espirais, triângulos e losangos repetidos. Esses desenhos são inspirados em animais, plantas e fenômenos naturais. Eles representam mitos, lendas, crenças e rituais, e cada etnia possui seu próprio estilo de grafismo, refletindo sua identidade cultural.\n\nYanomami\nOs Yanomami são habitantes da Amazônia, vivendo entre o Brasil e a Venezuela. Suas pinturas são usadas em rituais, cerimônias e caçadas, utilizando tintas naturais como o urucum (vermelho) e o genipapo (preto). Eles aplicam padrões geométricos e abstratos no corpo para expressar proteção espiritual, força e status. Cada grafismo tem um significado profundo, podendo representar espíritos da floresta, animais ou proteção.\n\nAtividade\nRealizamos uma atividade onde desenhamos um grafismo indígena que vimos na visita técnica ao museu indígena. Eu escolhi criar uma máscara típica dos indígenas, usada em rituais e cerimônias, incorporando os elementos que aprendemos sobre os grafismos.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/IMG_20240928_002046.jpg",
					"2": "res://Files/Sprites/classmanagerassets/download.png"
					}
			},
			"4": {
				"title": "Xilogravura, literatura de cordel e arte popular.",
				"text": "Atividades desenvolvidas em sala:\nOs colegas discutiram o que é a xilogravura, como ela é feita, onde é usada e quem é o principal artista. Também falaram sobre o cordel que leram e analisaram.\n\nO que é a Xilogravura?\nA xilogravura é uma técnica artística de impressão que consiste em gravar desenhos em uma matriz de madeira. Depois, a imagem é transferida para o papel por meio de tinta. Para criar a xilogravura, utiliza-se uma madeira apropriada e ferramentas específicas para rasgar e fazer sulcos na superfície. Após a arte estar pronta, aplica-se tinta sobre a matriz, e o papel é pressionado contra ela, transferindo assim o desenho.\n\nJ. Borges\nJ. Borges é um dos xilogravadores mais renomados do Brasil. Suas obras retratam cenas do sertão nordestino, trazendo à vida personagens folclóricos e festas populares que fazem parte da cultura local.\n\nLiteratura de Cordel\nA capa da literatura de cordel é ilustrada utilizando a técnica da xilogravura. A preservação e divulgação da xilogravura na cultura popular nordestina são de extrema importância, pois ajudam a manter vivas as tradições e histórias dessa rica região.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/xilogravados.jpeg",
					"2": "res://Files/Sprites/classmanagerassets/download (2).jpeg"
					}
			},
			"5": {
				"title": "Xilogravura e literatura de cordel",
				"text": "Atividades desenvolvidas em sala:\nNa aula, os colegas começaram a trabalhar no projeto bimestral, que consistia em criar um cordel e uma xilogravura para ser a capa do cordel.\n\nEstrutura do Cordel\nNós aprendemos sobre a estrutura do cordel, que consiste em 6 versos, sendo que no caso deles seriam 8 estrofes. As rimas são feitas apenas nos versos pares (2, 4 e 6), e cada verso precisa ter em média 7 sílabas.\n\nFazendo o Cordel\nDepois de aprender a estrutura, os alunos começaram a escrever seus cordéis.\nApesar de não ter entregue o meu cordel, eu o fiz após a data de entrega.\n\nO cordel segue:\n\nA Cobra do Cerrado\n\nNas terras do cerrado,\nVaga a cobra em seu andar,\nCom escamas reluzentes,\nEla sabe se ocultar.\nEntre as folhas e as pedras,\nÉ um mistério a vagar.\n\nCobra que dança e se esconde,\nNa sombra do matagal,\nEla traz uma sabedoria,\nQue vem do ancestral.\nSussurrando os segredos,\nDo verde, do bem e do mal.\n\nCom língua bifurcada,\nEla capta o ar sutil,\nUm olhar penetrante,\nE um jeito tão sutil.\nCaçadora do silêncio,\nNos trilhos do seu perfil.\n\nEm lendas é reverenciada,\nMestre das transformações,\nNa natureza é sagrada,\nNos ritos e tradições.\nRepresenta a força e o poder,\nE suas lições são canções.\n\nMas cuidado, viajante,\nCom seu jeito de atuar,\nRespeite a cobra, amigo,\nEla não vem pra atacar.\nSe você a deixar em paz,\nEla vai te respeitar.\n\nSe avistar uma serpente,\nCom calma, saiba lidar,\nNo mundo animal, ela é\nParte do que deve estar.\nCobra do cerrado, encanto,\nNa natureza a brilhar.\n\nAssim seguimos em frente,\nCom amor e gratidão,\nA cobra é proteção,\nE parte da criação.\nUm ser que traz harmonia,\nEm cada canção.\n\nXilogravura do Cordel",
				"images": {
					"1": "",
					"2": ""
					}
			}
		},
#endregion
#region Third semester
		"3": {
			"total_classes": "6",
			"1": {
				"title": "Arte romana",
				"text": "Atividades desenvolvidas em sala:\nNos vimos sobre a arte no período romano. Vimos a arquitetura, escultura, pintura e mosaico nessa época.\n\nArquitetura\nA arquitetura romana é uma das maiores contribuições deixadas pelos romanos para a história da arte.\n\nCaracterística principal: Uso dos arcos, uma técnica revolucionária para a época. O arco permitia a construção de estruturas mais resistentes e amplas.\n\nExemplo: Arco do Triunfo, um monumento construído para celebrar vitórias militares e homenagear os imperadores.\n\nPanteão de Agripa\nDestaque arquitetônico: Maior domo (abóboda) do mundo na época. Até hoje, ninguém fez outro domo com as mesmas proporções.\n\nFunção: Era um templo dedicado a todos os deuses da época, refletindo a religião politeísta romana.\n\nContexto histórico: A construção ocorreu antes da cristianização de Roma\n\nEscultura\nA escultura romana tem inspiração direta na escultura grega, mas com diferenças notáveis:\n\nRealismo: Os romanos adicionaram mais detalhes realísticos, especialmente nas feições humanas.\n\nMateriais utilizados: Usavam principalmente mármore e cobre.\n\nPintura\nAs pinturas romanas eram amplamente utilizadas para decoração de interiores e monumentos.\n\nUso: Decoração de palácios, templos e residências.\n\nDesgaste: Muitas pinturas desbotaram com o tempo, devido às condições climáticas e falta de preservação adequada.\n\nMosaico\nO mosaico foi uma das principais formas de arte decorativa romana\n\nFunção: Utilizado para decorar edifícios como casas, templos e banhos públicos.\n\nTécnica: Pequenas peças de pedra ou vidro (tesselas) eram organizadas para formar padrões, cenas mitológicas e paisagens.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/aula_1b.png",
					"2": "res://Files/Sprites/classmanagerassets/aula_1e.png"
					}
			},
			"2": {
				"title": "Mosaicos romanos",
				"text": "Atividades desenvolvidas em sala:\nFizemos uma atividade inspirada na arte mosaica romana. Os romanos pegavam pedras quase do mesmo tamanho e formavam um desenho.\n\nAtividade\nNós cortamos papéis em quadrados de mais ou menos o mesmo tamanho e de várias cores. Logo depois, colamos esses papéis em uma folha A4, formando, assim, um desenho.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/IMG_20250111_171741.jpg",
					"2": "res://Files/Sprites/classmanagerassets/images (3).jpeg"
					}
			},
			"3": {
				"title": "Arte gótica",
				"text": "Atividades desenvolvidas em sala:\nA gente viu sobre a arte gótica que surgiu na Europa durante a Idade Média. Essa arte substituiu as formas pesadas e robustas por construções mais leves, altas e ornamentadas. Vimos sobre a sua arquitetura, escultura e pintura.\n\nArquitetura\nA arquitetura gótica se destaca pela sua verticalidade, leveza estrutural e inovações técnicas que possibilitaram a construção de catedrais monumentais.\n\nInovações principais:\nArco ogival: Substituiu os arcos redondos românicos. Sua grande vantagem é a flexibilidade, permitindo maior altura e largura.\n\nAbóbadas em cruzaria: Distribuem o peso com eficiência, tornando desnecessárias paredes maciças.\n\nContrafortes externos: Sustentam a estrutura e permitem grandes vãos.\n\nVitrais: Painéis coloridos que iluminam o interior das catedrais, criando um efeito místico.\n\nEscultura\nA escultura gótica estava fortemente ligada à arquitetura e desempenhava um papel decorativo e religioso.\n\nCaracterísticas principais:\nEsculturas integradas às fachadas de igrejas e catedrais.\n\nRostos e poses naturalistas.\n\nUso frequente de figuras alongadas em pose de \"S\", como forma de representar leveza e movimento.\n\nPintura\nA pintura gótica evoluiu da iluminação de manuscritos para obras mais realistas e expressivas, mantendo a função educativa e religiosa.\n\nCaracterísticas principais:\nFiguras com proporções mais naturais e realistas.\n\nUso de luz e sombra para criar volume e profundidade.\n\nTemas religiosos, como cenas bíblicas e representações de santos.\n\nArtista destaque - Giotto di Bondone: Quebrou com o conservadorismo bizantino ao trazer realismo para a pintura.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/Vitral-na-Catedral-de-Chartres.jpeg",
					"2": "res://Files/Sprites/classmanagerassets/33ed332a031fcd7c7e0581bb0aeae137.webp"
					}
			},
			"4": {
				"title": "Fotos dos acontecimentos da semana",
				"text": "Assunto tratado:\nFotografia no IFG\n\nNessa aula, o professor propôs um trabalho que consistia em tirar uma foto que representasse um dia no IFG. O objetivo era capturar 5 momentos diferentes, cada um simbolizando a rotina de cada integrante na instituição.\n Eu infelizmente não participei dessa aula devido a problemas de saude.",
				"images": {
					"1": "",
					"2": ""
					}
			},
			"5": {
				"title": "Atividade com folhas",
				"text": "A aula foi realizada no auditório junto com o MEC. 1. Nela, fizemos uma atividade em que pegamos folhas das árvores do IFG. Colocamos uma folha A4 por cima da folha e passamos giz, de modo que os desenhos das folhas ficassem marcados no papel. Também desenhamos as folhas à mão.\n\nAtividade\nEu peguei três folhas e escolhi três cores, uma para cada folha. Depois, desenhei as folhas por cima da marca deixada pelo giz.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/IMG_20250111_171735.jpg",
					"2": ""
					}
			},
			"6": {
				"title": "Arte no Renascimento",
				"text": "Vimos sobre a arte no Renascimento, conhecendo seus principais artistas e obras, além das características que definiram esse período.\n\nRenascimento\nO Renascimento foi a união da vontade metódica dos romanos de estudar as coisas com o espírito explorador herdado dos góticos. Esse período marcou um renascimento das artes, ciências e do pensamento humano, trazendo avanços técnicos e estéticos.\n\nArtista e Obra\nLeonardo da Vinci\nConsiderado um dos maiores artistas do Renascimento, com contribuições revolucionárias tanto na arte quanto na ciência.\n\n- Obra icônica: A Última Ceia\n- Técnica utilizada: Têmpera, que combina pigmentos com clara de ovo para criar a tinta.\n- Inovações: Uso da perspectiva, profundidade e pontos de fuga para criar traços harmoniosos.\n- Detalhe provocador: Leonardo colocou rostos de filósofos nos lugares dos discípulos, numa sutil crítica à Igreja.\n\nReleitura da obra de Leonardo da Vinci\nReleitura é uma forma de usar uma obra de referência, mas acrescentar outros aspectos.\n\nMestre Ataíde\nArtista brasileiro do período Barroco. Nascido em Minas Gerais (1762-1830). Pintou a Última Ceia, mas com uma abordagem diferente.\n\n- Respeitou mais a tradição religiosa, incluindo elementos como a auréola e o cálice, ausentes na obra de Leonardo.\n- Sua versão apresenta mais movimento e descontração, conferindo um toque original.\n\nCaracterísticas do Renascimento\n- Perspectiva: Uso de pontos de fuga para criar profundidade e proporção nas pinturas.\n- Realismo: Detalhes mais naturais e expressivos.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/a-última-ceia_637685536.jpg",
					"2": "res://Files/Sprites/classmanagerassets/aula_6c.png"
					}
			}
		},
#endregion
#region Fourth semester
		"4": {
			"total_classes": "6",
			"1": {
				"title": "Arte Moderna e Impressionismo",
				"text": "Assunto tratado: arte moderna e o impressionismo, com exemplos representativos.\n\nModernismo:\nMovimento artístico do final do século XIX até meados do XX, marcado pela ruptura com tradições acadêmicas. Rejeitava o realismo detalhado, buscando expressão, subjetividade e crítica social.\nImpressionismo:\nSurgiu na França entre 1860 e 1870, influenciado pela fotografia. Artistas buscavam capturar a 'impressão' de um momento, com pinceladas rápidas e efeitos de luz e cor. Trabalhavam ao ar livre (*en plein air*).\n\nAtividade:\nDesenhamos uma paisagem ao ar livre. Escolhi retratar um beco entre os prédios do ginásio e laboratórios do campus Valparaíso.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/impressao-nascer-do-sol-monet-cke.jpg",
					"2": "res://Files/Sprites/classmanagerassets/images.jpg"
					}
			},
			"2": {
				"title": "Apresentação da atividade sobre impressionismo.",
				"text": "Assunto tratado: Sentamos em uma roda e apresentamos nossos trabalhos. Os nossos colegas fizeram obras de arte lindas e criativas.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/IMG_20250312_105104.jpg",
					"2": ""
					}
			},
		"3": {
			"title": "Cubismo",
			"text": "Assuntos tratados:\nVimos sobre o cubismo, um movimento artístico modernista, suas características, principais artistas e obras.\n\nCubismo:\nMovimento revolucionário que surgiu no início do século XX (por volta de 1907), em um período marcado por avanços científicos e influências de culturas não europeias. O cubismo questionou a representação tradicional da realidade, propondo uma visão intelectualizada e multidimensional do mundo. Rompeu radicalmente com a tradição artística ao abandonar a representação realista.\n\nCaracterísticas do Cubismo:\n- Fragmentação Geométrica: Objetos e figuras representados como formas geométricas (cubos, cilindros, cones) fragmentadas.\n- Múltiplas Perspectivas: Vários ângulos de visão (frente, lado, topo) em uma mesma obra.\n- Cores Neutras: Tons terrosos, cinzas e azuis, evitando cores vibrantes para não distrair da forma.\n- Influência da Arte Não Europeia: Artistas como Picasso e Braque foram impactados pela arte africana e ibérica, especialmente pelas máscaras rituais.\n\nPrincipais Artistas e Obras:\n- Pablo Picasso: 'Les Demoiselles d’Avignon'.\n- George Braque: 'Homem com Violão'.\n- Juan Gris: 'Retrato de Picasso'.\n\nAtividades desenvolvidas:\nA atividade consistiu em escolher um objeto e desenhá-lo de várias perspectivas. A cada intervalo de tempo, mudávamos de posição para capturar diferentes ângulos.\n Eu escolhi desenhar meus colegas, e a fusão de seus rostos junto a detalhes extras que eu incluí resultaram na obra ao lado.",
			"images": {
				"1": "res://Files/Sprites/classmanagerassets/cubismo.jpg",
				"2": "res://Files/Sprites/classmanagerassets/IMG_20250312_105053.jpg"
			}
		},
		"4": {
				"title": "Expressionismo e Fauvismo",
				"text": "Assuntos tratados:\nNessa aula, vimos sobre o expressionismo e o fauvismo, suas características, artistas e obras.\n\nExpressionismo:\nSurgiu no início do século XX, principalmente na Alemanha, como reação ao impressionismo e ao academicismo. Buscava expressar emoções subjetivas, como angústia e medo, em resposta às tensões sociais e à atmosfera pré-Primeira Guerra Mundial. Movimentos como o fauvismo e Die Brücke são associados ao expressionismo.\n\nCaracterísticas do Expressionismo:\n- Cores intensas e não realistas: Tons vibrantes e contrastantes para transmitir estados emocionais.\n- Distorção formal: Figuras deformadas, linhas agressivas e composições caóticas.\n- Temas sombrios: Solidão urbana, crítica social e o lado obscuro da modernidade.\n\nArtistas e Obras:\n- Edvard Munch: 'O Grito'.\n- Ernst Ludwig Kirchner: 'Autorretrato com Gato'.\n- Erich Heckel: 'Frühling (Primavera)'.\n\nDie Brücke:\nGrupo fundado em Dresden (1905), simbolizando a ideia de 'ligar' o passado ao futuro da arte.\n\nCaracterísticas do Die Brücke:\n- Estética crua e primitivista: Inspiração em arte africana e medieval.\n- Xilogravura: Técnica preferida, com cortes abruptos e texturas ásperas.\n- Temas urbanos e naturais: Retratos de ruas caóticas e paisagens distorcidas.\n\nArtistas e Obras:\n- Kirchner: 'Cena de Rua em Berlim'.\n- Heckel: 'Dois Feridos'.\n\nFauvismo:\nMovimento francês de curta duração (1905–1907), liderado por Henri Matisse. O termo 'fauvismo' surgiu de uma crítica que chamou os artistas de 'feras' devido ao uso agressivo de cores.\n\nCaracterísticas do Fauvismo:\n- Libertação da cor: Cores puras e não naturalistas.\n- Simplificação das formas: Contornos grossos e ausência de detalhes realistas.\n- Temas alegres: Natureza, paisagens e interiores, com foco na harmonia visual.\n\nArtistas e Obras:\n- Henri Matisse: 'A Faixa Verde'.\n- André Derain: 'Ponte sobre o Riou'.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/images_clock.jpg",
					"2": "res://Files/Sprites/classmanagerassets/fauvismo-og.webp"
				}
			},
			"5": {
				"title": "Autorretrato Expressionista",
				"text": "Assuntos tratados:\nA aula foi dedicada à construção de autorretratos, utilizando técnicas inspiradas no expressionismo. Assim como os expressionistas usavam cores e formas para representar sentimentos, aplicamos a mesma abordagem em nossos autorretratos.\n\nAtividades desenvolvidas:\n Eu fiz um autorretrato meu.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/IMG_20250312_105034.jpg",
					"2": ""
					}
			},
			"6": {
				"title": "Dadaísmo",
				"text": "Assuntos tratados:\nVimos sobre o movimento artístico dadaísmo, seus principais artistas, obras e características.\n\nDadaísmo:\nSurgiu entre 1916 e 1922, durante a Primeira Guerra Mundial, como resposta ao desespero e à destruição causados pelo conflito. Nascido em Zurique, espalhou-se por Berlim, Paris e Nova York. Os dadaístas rejeitavam a lógica, o nacionalismo e os valores burgueses, propondo uma arte que chocava e questionava.\n\nCaracterísticas do Dadaísmo:\n- Antiarte: Rejeição total das normas estéticas tradicionais, com obras criadas para chocar e ridicularizar a ideia de 'arte elevada'.\n- Ready-mades: Objetos comuns, como um urinol ou uma roda de bicicleta, eram assinados e exibidos como arte.\n- Colagens e Fotomontagens: Mistura de recortes de jornais, fotos e textos absurdos.\n- Absurdo: Obras sem lógica aparente, poemas fonéticos e performances caóticas.\n- Crítica Social e Política: Denúncia da hipocrisia burguesa, do militarismo e do capitalismo.\n\nPrincipais Artistas e Obras:\n- Marcel Duchamp: 'Fountain' e 'Roda de Bicicleta'.\n- Francis Picabia: 'L’Œil cacodylate'.\n- Raoul Hausmann: 'ABCD'.\n- Hannah Höch: 'Corte com a Faca de Cozinha'.\n\nAtividades desenvolvidas: Eu, usando revistas e livros, montei um quadro com imagens relacionadas a guerra e destruição, mas quiz também deixar o significado da obra vago e de uma forma até sem sentido.",
				"images": {
					"1": "res://Files/Sprites/classmanagerassets/dadaismo_o_que_e_e_como_surgiu_20077_orig.jpg",
					"2": "res://Files/Sprites/classmanagerassets/IMG_20250312_105044.jpg"
					}
			},
			"7": {
				"title": "Aula 7 Title",
				"text": "Aula 7 Text",
				"images": {
					"1": "res://Files/Sprites/arrow.png",
					"2": "res://Files/Sprites/arrow.png"
					}
			}
		}
	}
}
#endregion
