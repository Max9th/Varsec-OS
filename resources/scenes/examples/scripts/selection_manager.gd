extends Node

var selected_instance: TextureButton = null

func set_selected(instance: TextureButton):
	if selected_instance and selected_instance != instance:
		selected_instance.deselect()
	selected_instance = instance
