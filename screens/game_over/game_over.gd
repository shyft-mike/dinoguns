extends PanelContainer


func _on_restart_button_pressed():
	State.player.character.setup()
	GameManager.start()
