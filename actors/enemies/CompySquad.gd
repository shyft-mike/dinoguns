class_name CompySquad extends Node2D

@onready var spawn_points: Node2D = $SpawnPoints

var _frame_count: int = 0
var _remaining_cycles: int = 0
var _last_player_sighting: Vector2

var move_command: MoveCommand = MoveCommand.new()
var squad_members: Array[Enemy] = []


func _ready() -> void:
	# Take control of the chillens
	for spawn_point in spawn_points.get_children() as Array[Marker2D]:
		var compy_to_spawn = ActorFactory.generate_compy()
		compy_to_spawn.position = spawn_point.position
		compy_to_spawn.has_died.connect(_on_squad_member_died)
		add_child(compy_to_spawn)
		compy_to_spawn.clear_controller()
		squad_members.append(compy_to_spawn)


func _on_squad_member_died(dead_actor: Actor) -> void:
	var squad_idx = squad_members.find(dead_actor)
	squad_members.remove_at(squad_idx)
	if squad_idx < 3:
		reposition_squad(squad_idx)


func reposition_squad(idx_to_fill: int) -> void:
	for squad_member_idx in range(squad_members.size() - 1, -1, -1):
		pass


func _physics_process(delta):
	if _frame_count == 0 or _frame_count % 2 == 0:
		_handle_movement(delta)

	_frame_count += 1


func _handle_movement(delta):
	if _remaining_cycles == 0:
		_remaining_cycles = randi_range(15, 45)
		_last_player_sighting = State.player.global_position

	var distance_to_player = spawn_points.get_child(0).global_position.distance_to(_last_player_sighting)

	if distance_to_player > 50:
		var new_direction = spawn_points.get_child(0).global_position.direction_to(_last_player_sighting)
		for squad_member in squad_members:
			move_command.execute(squad_member, MoveCommand.Params.new(new_direction))

	_remaining_cycles -= 1

