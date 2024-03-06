extends CanvasLayer

signal start

func _on_button_pressed():
	start.emit()
