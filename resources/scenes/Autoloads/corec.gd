class_name corecoms extends Node

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
signal hide_os_billboards_signal
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

func start_event(shader: String = "res://resources/shaders/vignette.tres", background_image: String = "res://resources/sprites/background_unaligned.png", background_music: String = "res://resources/audio/eek.mp3", panel_color: Color = Color(27, 33, 48, 255), has_3d_wallpaper: bool = false,_3d_bk_path: String = "res://resources/scenes/others/easter/TEST.scn"):
	emit_signal("change_background_music_signal", background_music)
	emit_signal("change_panel_colors_signal", panel_color)
	emit_signal("change_vfx_shader_signal", shader)
	emit_signal("change_wallpaper_signal", background_image)
	hide_os_billboards_signal.emit()
	is_in_event = true
	print("CorecSE")

func switch_vfx_status():
	switch_vfx_status_signal.emit()
	print("CorecSVS")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("trigger_event_x_action") and is_in_splash == false:
		if is_in_event == true:
			interrupt_event_x.emit()
			is_in_event = false
		else:
			trigger_event_x.emit()
			is_in_event = true
			print("Triggered event X")

func stop_event_x():
	interrupt_event_x.emit()

@export var Database: Dictionary = {
	"class_data": {
#region First semester
		1: {
			"total_classes": 6,
			1: {
				"title": "Pontos e Pontilhismo",
				"text": "O pontilhismo é a arte de desenhar apenas com pontos.\nUm ponto pode representar o início e o fim de uma linha.\nPode também representar uma posição e/ou um cruzamento entre duas linhas.\nVale notar que toda linha é composta por diversos pontos.\nOs pontos são essenciais para a arte como um todo.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/pontilhismo.jpg",
					2: ""
					}
			},
			2: {
				"title": "Conceito de linhas, planos, luz e sombra",
				"text": "Atividades desenvolvidas em sala:\nVimos sobre os conceitos de linhas, planos, luz e sombra, além de analisarmos algumas obras que utilizaram esses elementos.\n\nLinha\nA linha é a trajetória de um ponto em movimento, tendo comprimento, mas sem largura.\nEla é considerada um rastro invisível, representando uma tensão ativa em contraste com a calma do ponto fixo.\n\nPlanos\nO plano é formado pela trajetória de uma linha em movimento, possuindo comprimento e largura, mas sem espessura.\nEle é delimitado por linhas e define os limites externos de um volume.\n\nLuz e sombra\nA linha define o formato, enquanto a sombra revela a forma tridimensional dos objetos.\nA iluminação guia a atenção de forma seletiva, destacando objetos sem depender de tamanho, cor ou posição central.\nObservamos uma cena em que a luz parecia emanar de um livro que Maria lia, iluminando a criança e projetando a sombra ampliada de José.\n\nAtividade\nRealizamos uma atividade prática de criação de um degradê utilizando linhas. A tarefa consistiu em desenhar linhas mais espaçadas no início e gradualmente torná-las mais próximas e cruzadas, gerando um efeito mais escuro.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/sobre-um-plano-so-podem-ser-feitas-imagens-duas-dimensoes-58d51308ee80b.webp",
					2: ""
					}
			},
			3: {
				"title": "Cores",
				"text": "Assunto tratado:\nCores primárias, secundárias e terciárias, cores quentes e frias.\n\nAtividades desenvolvidas em sala:\nVimos sobre as cores primárias, secundárias e terciárias, e o conceito de cores quentes e frias.\n\nCores primárias, secundárias e terciárias\nCores primárias são a base para criar outras cores: vermelho, verde e azul.\nCores secundárias são criadas pela mistura de duas cores primárias, resultando em cores como verde, laranja e roxo.\nCores terciárias são criadas pela mistura de uma cor primária com uma cor secundária, resultando em cores como azul-esverdeado, vermelho-alaranjado e amarelo-esverdeado.\n\nCores quentes e frias\nAs cores quentes (vermelho, laranja, amarelo) transmitem energia.\nAs cores frias (azul, verde, roxo) transmitem calma.\n\nAtividade\nRealizamos uma atividade prática de criação de um círculo cromático com as cores primárias, secundárias e terciárias, aplicando os conceitos aprendidos.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/timthumb.png",
					2: ""
					}
			},
			4: {
				"title": "Cores complementares e análogas",
				"text": "Atividades desenvolvidas em sala:\nVimos sobre as cores complementares e análogas e como essas cores interagem no círculo cromático.\n\nCores complementares e análogas\nCores complementares são aquelas que estão opostas no círculo cromático, criando contraste.\nCores análogas são aquelas que estão lado a lado no círculo cromático, criando harmonia.\n\nAtividade\nComplementamos a atividade anterior, incluindo as cores primárias e suas cores análogas.\nTambém realizamos uma obra utilizando pontos e linhas para juntar cores.\nAlém disso, tivemos uma atividade para casa, onde deveríamos criticar o trabalho de um colega, descrevendo-o e analisando-o.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/timthumb.png",
					2: "res://resources/sprites/classmanagerassets/rust-gold-8-32x.png"
					}
			},
			5: {
				"title": "Trabalho bimestral: Arte com copos",
				"text": "Atividades desenvolvidas em sala:\nIniciamos o projeto bimestral de artes, com o professor apresentando uma obra de referência para guiar o processo.\nPrimeiro, decidimos qual desenho criar e optamos por um arco-íris, pois essa imagem permite o uso de várias cores, tornando a obra visualmente mais interessante.\nCriamos um modelo inicial para termos uma visão de como ficaria o desenho final.\nPara iniciar o desenho, utilizamos copos vazios, posicionando-os do centro até as extremidades para formar um arco o mais preciso possível. Em seguida, desenhamos as nuvens que serviriam como base para o arco-íris.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/atividade-5a.png",
					2: ""
					}
			},
			6: {
				"title": "Trabalho bimestral: Arte com copos",
				"text": "Atividades desenvolvidas em sala:\nFinalizamos o trabalho bimestral, com o professor fornecendo três cores primárias: vermelho, amarelo e azul.\nEnchemos os copos com água e adicionamos tinta, misturando as cores para criar novas tonalidades e tornar o arco-íris mais detalhado.\nTambém fizemos mais alguns detalhes ao redor do desenho, como nuvens e estrelas.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/atividade-5a.png",
					2: "res://resources/sprites/classmanagerassets/atividade-5b.jpg"
					}
			}
		},
#endregion
#region Second semester
		2: {
			"total_classes": 5,
			1: {
				"title": "Identidade cultural, povos originários, arte marajoara",
				"text": "Atividades desenvolvidas em sala:\nDesenho baseado em duas espécies de animais brasileiros fundidos em um único ser. Eu usei um morcego fruteiro e uma jararaca-de-alcatrazes.\nFalamos sobre a arte marajoara, os povos originários e a identidade cultural.\n\nArte Marajoara\nA arte marajoara foi criada pelo povo que vivia na Ilha de Marajó entre os anos 400 e 1400 d.C. Ela é mais conhecida pelas cerâmicas com formas geométricas e detalhes bem elaborados.\n\nPovos Originários\nOs povos indígenas no Brasil têm uma diversidade cultural e artística gigante. Eles produzem coisas como pinturas corporais, cerâmicas, cestaria e histórias mitológicas. A arte é super importante para rituais religiosos, se conectar com a natureza e manter viva a memória cultural.\n\nIdentidade Cultural\nA identidade cultural está ligada aos valores, tradições e crenças de cada grupo. Na arte, ela aparece através de símbolos, estilos e técnicas que são passados de geração em geração. Os povos usam a arte para mostrar como veem o mundo e registrar suas experiências.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/1271416569_4a3d19b1ff_b.jpg",
					2: "res://resources/sprites/classmanagerassets/1727438391663.jpg"
					}
			},
			2: {
				"title": "Visíta técnica ao Museu dos Povos Indigenas",
				"text": "Atividades desenvolvidas em sala:\nMeus colegas foram ao museu dos povos indígenas, onde tiveram a oportunidade de conhecer diversas etnias e suas culturas. Eles observaram uma rica variedade de grafismos indígenas, tanto em cerâmicas quanto em máscaras e cestos.\n\nMáscaras Indígenas\nAs máscaras que eles viram, usadas em rituais e cerimônias, eram intrigantes. Cada uma possui sua própria simbologia e serve para representar espíritos ou personagens significativos nas tradições culturais.\n\nVasilhas de Cerâmica\nAs vasilhas de cerâmica que foram exibidas eram notáveis, com algumas apresentando desenhos ricos e detalhados, refletindo as tradições e a identidade cultural de cada povo.\n\nColar de Penas\nEles também viram colares feitos com penas, que são adornos tradicionais e têm um papel importante nas expressões culturais e espirituais dos indígenas.\n\nCestas Coloridas\nAs cestas que eles observaram eram de diversos tamanhos e formatos, confeccionadas com materiais vibrantes, evidenciando a habilidade e a criatividade dos artesãos indígenas.\n\nMadeira Esculpida\nOs colegas tiveram a oportunidade de ver esculturas em madeira que representavam animais, adornadas com desenhos que contam histórias e mostram a conexão dos indígenas com a natureza.\n\nMural com Grafismos\nPor fim, eles encontraram um mural desenhado no estilo do grafismo indígena, repleto de figuras de animais e formas geométricas. Esse mural destaca a biodiversidade e a profunda relação espiritual que os povos indígenas mantêm com o meio ambiente.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/aula_2d.jpeg",
					2: "res://resources/sprites/classmanagerassets/aula_2a.jpeg"
					}
			},
			3: {
				"title": "Grafismo indígena, povos Yanomami, arte indígena",
				"text": "Atividades desenvolvidas em sala:\nVimos sobre o grafismo indígena, com foco especial nos Yanomami e seus grafismos.\n\nGrafismo Indígena\nO grafismo indígena é caracterizado pelo uso de linhas, zigue-zagues, espirais, triângulos e losangos repetidos. Esses desenhos são inspirados em animais, plantas e fenômenos naturais. Eles representam mitos, lendas, crenças e rituais, e cada etnia possui seu próprio estilo de grafismo, refletindo sua identidade cultural.\n\nYanomami\nOs Yanomami são habitantes da Amazônia, vivendo entre o Brasil e a Venezuela. Suas pinturas são usadas em rituais, cerimônias e caçadas, utilizando tintas naturais como o urucum (vermelho) e o genipapo (preto). Eles aplicam padrões geométricos e abstratos no corpo para expressar proteção espiritual, força e status. Cada grafismo tem um significado profundo, podendo representar espíritos da floresta, animais ou proteção.\n\nAtividade\nRealizamos uma atividade onde desenhamos um grafismo indígena que vimos na visita técnica ao museu indígena. Eu escolhi criar uma máscara típica dos indígenas, usada em rituais e cerimônias, incorporando os elementos que aprendemos sobre os grafismos.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/IMG_20240928_002046.jpg",
					2: "res://resources/sprites/classmanagerassets/download.png"
					}
			},
			4: {
				"title": "Xilogravura, literatura de cordel e arte popular.",
				"text": "Atividades desenvolvidas em sala:\nOs colegas discutiram o que é a xilogravura, como ela é feita, onde é usada e quem é o principal artista. Também falaram sobre o cordel que leram e analisaram.\n\nO que é a Xilogravura?\nA xilogravura é uma técnica artística de impressão que consiste em gravar desenhos em uma matriz de madeira. Depois, a imagem é transferida para o papel por meio de tinta. Para criar a xilogravura, utiliza-se uma madeira apropriada e ferramentas específicas para rasgar e fazer sulcos na superfície. Após a arte estar pronta, aplica-se tinta sobre a matriz, e o papel é pressionado contra ela, transferindo assim o desenho.\n\nJ. Borges\nJ. Borges é um dos xilogravadores mais renomados do Brasil. Suas obras retratam cenas do sertão nordestino, trazendo à vida personagens folclóricos e festas populares que fazem parte da cultura local.\n\nLiteratura de Cordel\nA capa da literatura de cordel é ilustrada utilizando a técnica da xilogravura. A preservação e divulgação da xilogravura na cultura popular nordestina são de extrema importância, pois ajudam a manter vivas as tradições e histórias dessa rica região.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/xilogravados.jpeg",
					2: "res://resources/sprites/classmanagerassets/download (2).jpeg"
					}
			},
			5: {
				"title": "Xilogravura e literatura de cordel",
				"text": "Atividades desenvolvidas em sala:\nNa aula, os colegas começaram a trabalhar no projeto bimestral, que consistia em criar um cordel e uma xilogravura para ser a capa do cordel.\n\nEstrutura do Cordel\nNós aprendemos sobre a estrutura do cordel, que consiste em 6 versos, sendo que no caso deles seriam 8 estrofes. As rimas são feitas apenas nos versos pares (2, 4 e 6), e cada verso precisa ter em média 7 sílabas.\n\nFazendo o Cordel\nDepois de aprender a estrutura, os alunos começaram a escrever seus cordéis.\nApesar de não ter entregue o meu cordel, eu o fiz após a data de entrega.\n\nO cordel segue:\n\nA Cobra do Cerrado\n\nNas terras do cerrado,\nVaga a cobra em seu andar,\nCom escamas reluzentes,\nEla sabe se ocultar.\nEntre as folhas e as pedras,\nÉ um mistério a vagar.\n\nCobra que dança e se esconde,\nNa sombra do matagal,\nEla traz uma sabedoria,\nQue vem do ancestral.\nSussurrando os segredos,\nDo verde, do bem e do mal.\n\nCom língua bifurcada,\nEla capta o ar sutil,\nUm olhar penetrante,\nE um jeito tão sutil.\nCaçadora do silêncio,\nNos trilhos do seu perfil.\n\nEm lendas é reverenciada,\nMestre das transformações,\nNa natureza é sagrada,\nNos ritos e tradições.\nRepresenta a força e o poder,\nE suas lições são canções.\n\nMas cuidado, viajante,\nCom seu jeito de atuar,\nRespeite a cobra, amigo,\nEla não vem pra atacar.\nSe você a deixar em paz,\nEla vai te respeitar.\n\nSe avistar uma serpente,\nCom calma, saiba lidar,\nNo mundo animal, ela é\nParte do que deve estar.\nCobra do cerrado, encanto,\nNa natureza a brilhar.\n\nAssim seguimos em frente,\nCom amor e gratidão,\nA cobra é proteção,\nE parte da criação.\nUm ser que traz harmonia,\nEm cada canção.\n\nXilogravura do Cordel",
				"images": {
					1: "",
					2: ""
					}
			}
		},
#endregion
#region Third semester
		3: {
			"total_classes": 6,
			1: {
				"title": "Arte romana",
				"text": "Atividades desenvolvidas em sala:\nNos vimos sobre a arte no período romano. Vimos a arquitetura, escultura, pintura e mosaico nessa época.\n\nArquitetura\nA arquitetura romana é uma das maiores contribuições deixadas pelos romanos para a história da arte.\n\nCaracterística principal: Uso dos arcos, uma técnica revolucionária para a época. O arco permitia a construção de estruturas mais resistentes e amplas.\n\nExemplo: Arco do Triunfo, um monumento construído para celebrar vitórias militares e homenagear os imperadores.\n\nPanteão de Agripa\nDestaque arquitetônico: Maior domo (abóboda) do mundo na época. Até hoje, ninguém fez outro domo com as mesmas proporções.\n\nFunção: Era um templo dedicado a todos os deuses da época, refletindo a religião politeísta romana.\n\nContexto histórico: A construção ocorreu antes da cristianização de Roma\n\nEscultura\nA escultura romana tem inspiração direta na escultura grega, mas com diferenças notáveis:\n\nRealismo: Os romanos adicionaram mais detalhes realísticos, especialmente nas feições humanas.\n\nMateriais utilizados: Usavam principalmente mármore e cobre.\n\nPintura\nAs pinturas romanas eram amplamente utilizadas para decoração de interiores e monumentos.\n\nUso: Decoração de palácios, templos e residências.\n\nDesgaste: Muitas pinturas desbotaram com o tempo, devido às condições climáticas e falta de preservação adequada.\n\nMosaico\nO mosaico foi uma das principais formas de arte decorativa romana\n\nFunção: Utilizado para decorar edifícios como casas, templos e banhos públicos.\n\nTécnica: Pequenas peças de pedra ou vidro (tesselas) eram organizadas para formar padrões, cenas mitológicas e paisagens.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/aula_1b.png",
					2: "res://resources/sprites/classmanagerassets/aula_1e.png"
					}
			},
			2: {
				"title": "Mosaicos romanos",
				"text": "Atividades desenvolvidas em sala:\nFizemos uma atividade inspirada na arte mosaica romana. Os romanos pegavam pedras quase do mesmo tamanho e formavam um desenho.\n\nAtividade\nNós cortamos papéis em quadrados de mais ou menos o mesmo tamanho e de várias cores. Logo depois, colamos esses papéis em uma folha A4, formando, assim, um desenho.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/IMG_20250111_171741.jpg",
					2: "res://resources/sprites/classmanagerassets/images (3).jpeg"
					}
			},
			3: {
				"title": "Arte gótica",
				"text": "Atividades desenvolvidas em sala:\nA gente viu sobre a arte gótica que surgiu na Europa durante a Idade Média. Essa arte substituiu as formas pesadas e robustas por construções mais leves, altas e ornamentadas. Vimos sobre a sua arquitetura, escultura e pintura.\n\nArquitetura\nA arquitetura gótica se destaca pela sua verticalidade, leveza estrutural e inovações técnicas que possibilitaram a construção de catedrais monumentais.\n\nInovações principais:\nArco ogival: Substituiu os arcos redondos românicos. Sua grande vantagem é a flexibilidade, permitindo maior altura e largura.\n\nAbóbadas em cruzaria: Distribuem o peso com eficiência, tornando desnecessárias paredes maciças.\n\nContrafortes externos: Sustentam a estrutura e permitem grandes vãos.\n\nVitrais: Painéis coloridos que iluminam o interior das catedrais, criando um efeito místico.\n\nEscultura\nA escultura gótica estava fortemente ligada à arquitetura e desempenhava um papel decorativo e religioso.\n\nCaracterísticas principais:\nEsculturas integradas às fachadas de igrejas e catedrais.\n\nRostos e poses naturalistas.\n\nUso frequente de figuras alongadas em pose de \"S\", como forma de representar leveza e movimento.\n\nPintura\nA pintura gótica evoluiu da iluminação de manuscritos para obras mais realistas e expressivas, mantendo a função educativa e religiosa.\n\nCaracterísticas principais:\nFiguras com proporções mais naturais e realistas.\n\nUso de luz e sombra para criar volume e profundidade.\n\nTemas religiosos, como cenas bíblicas e representações de santos.\n\nArtista destaque - Giotto di Bondone: Quebrou com o conservadorismo bizantino ao trazer realismo para a pintura.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/Vitral-na-Catedral-de-Chartres.jpeg",
					2: "res://resources/sprites/classmanagerassets/33ed332a031fcd7c7e0581bb0aeae137.webp"
					}
			},
			4: {
				"title": "Fotos dos acontecimentos da semana",
				"text": "Assunto tratado:\nFotografia no IFG\n\nNessa aula, o professor propôs um trabalho que consistia em tirar uma foto que representasse um dia no IFG. O objetivo era capturar 5 momentos diferentes, cada um simbolizando a rotina de cada integrante na instituição.\n Eu infelizmente não participei dessa aula devido a problemas de saude.",
				"images": {
					1: "",
					2: ""
					}
			},
			5: {
				"title": "Atividade com folhas",
				"text": "A aula foi realizada no auditório junto com o MEC. 1. Nela, fizemos uma atividade em que pegamos folhas das árvores do IFG. Colocamos uma folha A4 por cima da folha e passamos giz, de modo que os desenhos das folhas ficassem marcados no papel. Também desenhamos as folhas à mão.\n\nAtividade\nEu peguei três folhas e escolhi três cores, uma para cada folha. Depois, desenhei as folhas por cima da marca deixada pelo giz.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/IMG_20250111_171735.jpg",
					2: ""
					}
			},
			6: {
				"title": "Arte no Renascimento",
				"text": "Vimos sobre a arte no Renascimento, conhecendo seus principais artistas e obras, além das características que definiram esse período.\n\nRenascimento\nO Renascimento foi a união da vontade metódica dos romanos de estudar as coisas com o espírito explorador herdado dos góticos. Esse período marcou um renascimento das artes, ciências e do pensamento humano, trazendo avanços técnicos e estéticos.\n\nArtista e Obra\nLeonardo da Vinci\nConsiderado um dos maiores artistas do Renascimento, com contribuições revolucionárias tanto na arte quanto na ciência.\n\n- Obra icônica: A Última Ceia\n- Técnica utilizada: Têmpera, que combina pigmentos com clara de ovo para criar a tinta.\n- Inovações: Uso da perspectiva, profundidade e pontos de fuga para criar traços harmoniosos.\n- Detalhe provocador: Leonardo colocou rostos de filósofos nos lugares dos discípulos, numa sutil crítica à Igreja.\n\nReleitura da obra de Leonardo da Vinci\nReleitura é uma forma de usar uma obra de referência, mas acrescentar outros aspectos.\n\nMestre Ataíde\nArtista brasileiro do período Barroco. Nascido em Minas Gerais (1762-1830). Pintou a Última Ceia, mas com uma abordagem diferente.\n\n- Respeitou mais a tradição religiosa, incluindo elementos como a auréola e o cálice, ausentes na obra de Leonardo.\n- Sua versão apresenta mais movimento e descontração, conferindo um toque original.\n\nCaracterísticas do Renascimento\n- Perspectiva: Uso de pontos de fuga para criar profundidade e proporção nas pinturas.\n- Realismo: Detalhes mais naturais e expressivos.",
				"images": {
					1: "res://resources/sprites/classmanagerassets/a-última-ceia_637685536.jpg",
					2: "res://resources/sprites/classmanagerassets/aula_6c.png"
					}
			}
		},
#endregion
#region Fourth semester
		4: {
			"total_classes": 7,
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
#endregion
