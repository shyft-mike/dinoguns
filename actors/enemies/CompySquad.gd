class_name CompySquad extends Node2D

var _frame_count: int = 0
var _remaining_cycles: int = 0
var _last_player_sighting: Vector2

var move_command: MoveCommand = MoveCommand.new()
var squad_members: Array[Enemy] = []


func _ready() -> void:
	# Take control of the chillens
	for compy in get_children() as Array[Enemy]:
		compy.clear_controller()
		squad_members.append(compy)


func _physics_process(delta):
	if _frame_count == 0 or _frame_count % 2 == 0:
		_handle_movement(delta)

	_frame_count += 1


func _handle_movement(delta):
	if _remaining_cycles == 0:
		_remaining_cycles = randi_range(15, 45)
		_last_player_sighting = State.player.global_position

	var distance_to_player = squad_members[0].global_position.distance_to(_last_player_sighting)

	if distance_to_player > 50:
		var new_direction = squad_members[0].global_position.direction_to(_last_player_sighting)
		for squad_member in squad_members:
			move_command.execute(squad_member, MoveCommand.Params.new(new_direction))

	_remaining_cycles -= 1

