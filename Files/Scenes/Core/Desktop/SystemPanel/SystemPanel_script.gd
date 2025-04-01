extends PanelContainer



func _on_resized() -> void:
	Core.define_panel_height(self.size.y + self.position.y)
	print("a")
