class_name MoveCommand
extends Command

class Params:
	var direction_vector: Vector2
	
	func _init(direction_vector: Vector2) -> void:
		self.direction_vector = direction_vector


func execute(actor: Actor, data: Object = null) -> void:
	if data is Params:
		actor.move(data.direction_vector)
