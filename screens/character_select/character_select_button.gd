extends Button
class_name CharacterSelectButton

signal character_selected (character)

var character: Character


func init(character_in: Character):
	character = character_in
	
	$Label.text = character.name
	$TextureRect.texture = character.icon
	
	if not character.is_selectable:
		disabled = true
		focus_mode = Control.FOCUS_NONE
		
		$TextureRect.modulate = Color.DIM_GRAY


func _on_pressed():
	character_selected.emit(character)
