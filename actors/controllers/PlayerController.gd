class_name PlayerController
extends ActorController


func _handle_input() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	move_command.execute(actor, MoveCommand.Params.new(direction))


func _update_ability_position(ability: Ability) -> void:
	var new_ability_scale = -1 if actor._flipped else 1
	ability.global_position = actor.hand_marker.global_position

	if ability.can_rotate:
		ability.rotation = ability.global_position.angle_to_point(ability.get_global_mouse_position())
		if actor._flipped:
			if ability.rotation_degrees < 90 and ability.rotation_degrees > -90:
				new_ability_scale *= -1
		else:
			if ability.rotation_degrees > 90 or ability.rotation_degrees < -90:
				new_ability_scale *= -1

	ability.scale.y = new_ability_scale


func _handle_abilities(delta) -> void:
	for ability in actor._ability_container.get_children():
		if ability is Ability:
			_update_ability_position(ability)

			if ability.elapsed >= ability.interval:
				ability.activate(actor, actor.hand_marker)

			ability.elapsed += delta


func _physics_process(delta) -> void:
	if actor.stat_manager.is_dead:
		return

	_handle_input()
	_handle_abilities(delta)
