class_name PlayerController
extends ActorController


func _handle_input() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	move_command.execute(actor, MoveCommand.Params.new(direction))


func _handle_abilities(delta) -> void:
	for ability in actor._ability_container.get_children():
		if ability is Ability:
			ability.elapsed += delta * 1000
			if ability.elapsed >= ability.interval:
				ability.activate(actor, actor.hand_marker)


func _physics_process(delta) -> void:
	if actor.stat_manager.is_dead:
		return

	_handle_input()
	_handle_abilities(delta)
