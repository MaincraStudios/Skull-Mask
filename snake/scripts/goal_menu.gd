extends CanvasLayer

signal goal

func _on_button_pressed():
	goal.emit()
