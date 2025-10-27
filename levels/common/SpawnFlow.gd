class_name SpawnFlow
extends RefCounted

enum SpawnPattern { RANDOM, GROUP, AT_NODE }

class SpawnEvent:
	var event_name: String
	var at_minutes_elapsed: float
	var spawn: int
	var count: int
	var pattern: SpawnPattern
	var repeat_rate: float
	var last_run_at: float

	func _init(line: String):
		var fields = line.split(",") # Split the line by comma to get individual fields.
		event_name = fields[0]
		at_minutes_elapsed = float(fields[1])
		#spawn = CharacterFactory.CharacterType.get(fields[2])
		count = int(fields[3])
		pattern = SpawnPattern.get(fields[4])
		repeat_rate = float(fields[5])


var one_off_events: Array[SpawnEvent] = []
var repeat_events: Array[SpawnEvent] = []


func _init(spawn_pattern_file: FileAccess):
	# skip header
	var header_line = spawn_pattern_file.get_line()

	while not spawn_pattern_file.eof_reached():
		var line = spawn_pattern_file.get_line()
		var event = SpawnEvent.new(line)

		if event.repeat_rate == 0.0:
			one_off_events.append(event)
		else:
			repeat_events.append(event)

	spawn_pattern_file.close()


func get_spawn_events(elapsed_time: float) -> Array[SpawnEvent]:
	var results: Array[SpawnEvent] = []

	for i in one_off_events.size():
		var event = one_off_events[-i-1]
		if event.at_minutes_elapsed <= elapsed_time:
			results.append(event)
			one_off_events.remove_at(i)

	for i in repeat_events.size():
		var event = repeat_events[-i-1]
		var since_last_event = elapsed_time - event.last_run_at
		if event.at_minutes_elapsed <= elapsed_time and event.repeat_rate <= since_last_event:
			event.last_run_at = elapsed_time
			results.append(event)

	return results
