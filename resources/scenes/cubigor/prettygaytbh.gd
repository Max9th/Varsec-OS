extends Node2D
#these are variables:
@onready var person_theme: AudioStreamPlayer = $gaytheme
var person_mode: bool = false
#Here, a signal was defined
signal Disablebk

func person_spawner():  # tells the computer that if he's in person mode, he should emit the signal disablebk, and check if the music really is playing
	if person_mode:
		if not person_theme.playing:  
			person_theme.playing = true #Here, the property "playing" from the "person_theme" node was modified
		Disablebk.emit() #Emits a signal. Who would've guessed :D
	else:
		if person_theme.playing:
			person_theme.stop()


func _on_authenticated() -> void: #this is system generated function that activates when receiving a signal called "authenticated"
		person_mode = true
		person_spawner() # Calls the "Person spawner" function
