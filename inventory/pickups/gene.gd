extends Item

@export var exp_value := 10


func on_pickup():
	Events.experience_received.emit(exp_value)
	queue_free()
