extends Button
class_name CharacterSelectButton

signal character_hovered (character)

var _character: Character


func setup(character: Character):
	_character = character
	
	$Label.text = _character.name
	$TextureRect.texture = _character.icon
	
	if not _character.is_selectable:
		disabled = true
		focus_mode = Control.FOCUS_NONE
		
		$TextureRect.modulate = Color.DIM_GRAY


func _on_pressed():
	Events.character_selected.emit(_character)


func _on_mouse_entered():
	character_hovered.emit(_character)

