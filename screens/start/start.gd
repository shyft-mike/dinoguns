extends PanelContainer


func _on_button_pressed():
#	SceneManager.change_scene(SceneManager.CHARACTER_SELECT_SCENE)
	var new_player = CharacterFactory.generate_character_template(CharacterFactory.CharacterType.RAPTOR).instantiate()
#	new_player.character = CharacterFactory.generate_character_sheet(CharacterFactory.CharacterType.RAPTOR)
	
	Events.character_selected.emit(new_player)
