class_name EnemyController
extends ActorController

var _frame_count: int = 0
var _remaining_cycles: int = 0
var _last_player_sighting: Vector2

func _physics_process(delta):
	if _frame_count == 0 or _frame_count % 2 == 0:
		_handle_movement(delta)

	_frame_count += 1


func _handle_movement(delta):
	if _remaining_cycles == 0:
		_remaining_cycles = randi_range(15, 45)
		_last_player_sighting = State.player.global_position

	var distance_to_player = actor.global_position.distance_to(_last_player_sighting)

	if distance_to_player > 50:
		var new_direction = actor.global_position.direction_to(_last_player_sighting)
		new_direction.x += randf_range(-8.0, 8.0) * delta
		new_direction.y += randf_range(-8.0, 8.0) * delta
		move_command.execute(actor, MoveCommand.Params.new(new_direction))

	_remaining_cycles -= 1
