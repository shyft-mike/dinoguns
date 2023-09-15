extends Level

@onready var spawn_timer: Timer = $SpawnTimer

var spawn_flow: SpawnFlow
var seconds_elapsed: int


func _ready():
	seconds_elapsed = 0
	
	spawn_flow = SpawnFlow.new() \
		.add_group("initial_spawn", 0.0) \
			.add_event(CharacterFactory.CharacterType.COMPY, 50) \
			.done() \
		.add_group("spawn 2", 0.2) \
			.add_event(CharacterFactory.CharacterType.COMPY, 60) \
			.done() \
		.add_group("1 minute in", 1.0, SpawnFlow.SpawnPositioning.GROUPED) \
			.add_event(CharacterFactory.CharacterType.COMPY, 80) \
			.add_event(CharacterFactory.CharacterType.MEGA_COMPY, 5) \
			.done() \
		.done()
		
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	
	
func _on_spawn_timer_timeout():
	seconds_elapsed += 1
	
	if spawn_flow.spawn_flow_data.size() > 0:
		var next_group = spawn_flow.spawn_flow_data[0]
		
		if next_group.at_time_elapsed <= (seconds_elapsed / 60.0):
			# handle spawning all the groups of spawn events
			for event in next_group.events:
				for i in event.count:
					SpawnManager.spawn(event.to_spawn)
			spawn_flow.spawn_flow_data.remove_at(0)
			
