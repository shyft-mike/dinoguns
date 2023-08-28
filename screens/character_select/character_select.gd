extends Panel


func _ready():
	var characters = _get_characters()
	
	for character in characters:
		var button = preload("res://screens/character_select/character_select_button.tscn").instantiate()
		button.setup(character)
		button.character_hovered.connect(_on_character_hovered)
		$GridContainer.add_child(button)
		

func _get_characters():
	var results = _get_selectable_characters()
	
	return results
	
	
func _get_selectable_characters():
	var results = []
	
	#TODO: get all characters, grey out unselectable
	
	for character_type in CharacterFactory.CharacterType.values():
		results.append(CharacterFactory.generate_character(character_type))
		
	return results


func _on_character_hovered(character):
	print_debug("Character hovered: " + character.name)
	$StatsPanel.load_character(character)
