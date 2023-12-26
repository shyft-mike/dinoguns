class_name RicochetModifier
extends Modifier

var _max_bounces: int


func _init(max_bounces: int = 2):
	_max_bounces = max_bounces


func modify_damager_collide(damager: Damager, collided_actor: Actor) -> void:
	if damager.hit_count == _max_bounces:
		return

	var bounce_direction

	if "direction" in damager:
		bounce_direction = damager.direction.bounce(collided_actor.global_position.normalized())
		damager.direction = bounce_direction
	else:
		bounce_direction = damager.user._facing.bounce(collided_actor.global_position.normalized())

	damager.rotation = bounce_direction.angle()
