extends Panel

signal start_button_pressed


func _on_button_pressed():
	start_button_pressed.emit()
