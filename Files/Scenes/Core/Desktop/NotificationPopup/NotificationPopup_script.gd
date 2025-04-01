extends PanelContainer

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func _ready() -> void:
	Core.connect("send_notification_signal", display_notification)

func display_notification(text: String):
	label.text = text
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	await tween.tween_property(self,"position:y", 100, 1).finished
	timer.start()


func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	await tween.tween_property(self,"position:y", -55, 1).finished
	label.text = ""
