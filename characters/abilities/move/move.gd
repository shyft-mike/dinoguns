class_name Move
extends Node


func execute(character: Character, direction: Vector2, delta: float):
	if not direction.is_normalized(): 
		direction = direction.normalized()
	
	var new_velocity = direction * CharacterService.calc_move_speed(character)
	
	character.previous_position = character.position
	
	if "move_and_slide" in character:
		character.velocity = new_velocity
		character.move_and_slide()
	else:
		character.position += new_velocity * delta
		
	character.linear_velocity = (character.position - character.previous_position) / delta
	
