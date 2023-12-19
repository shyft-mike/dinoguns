class_name ExpPickup
extends Item

@export var exp_value := 10


func pickup():
	CharacterService.add_experience(State.player, exp_value)
	remove()
