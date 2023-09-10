class_name ExpPickup
extends Item

@export var exp_value := 10


func on_pickup():
	State.player.character.add_experience(exp_value)
	remove()
