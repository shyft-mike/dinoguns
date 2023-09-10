extends Button
class_name CharacterSelectButton

signal character_hovered (character)

var _character: CharacterSheet


func setup(character: CharacterSheet):
	_character = character
	
	$Label.text = _character.name
	$TextureRect.texture = _character.icon
	
	if not _character.is_selectable:
		disabled = true
		focus_mode = Control.FOCUS_NONE
		
		$TextureRect.modulate = Color.DIM_GRAY


func _on_pressed():
	var new_player = CharacterFactory.generate_character_template(_character.type).instantiate()
	new_player.character = _character
	
	Events.character_selected.emit(new_player)


func _on_mouse_entered():
	character_hovered.emit(_character)

