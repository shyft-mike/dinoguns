extends Item

@export var exp_value := 10


func on_pickup():
	State.selected_character.add_experience(exp_value)
	queue_free()
