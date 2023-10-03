class_name Move
extends Node


func execute(character: Character, direction: Vector2):
	if not direction.is_normalized(): 
		direction = direction.normalized()
	
	character.velocity = direction * CharacterService.calc_move_speed(character)
	character.move_and_slide()
