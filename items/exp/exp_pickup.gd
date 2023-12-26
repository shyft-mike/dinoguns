class_name ExpPickup
extends Item

@export var exp_value := 10


func pickup():
	State.player.stat_manager.add_experience(exp_value)
	remove()
