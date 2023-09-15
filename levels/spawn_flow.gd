class_name SpawnFlow
extends RefCounted

enum SpawnPositioning { RANDOM, GROUPED, SPECIFIED }


class SpawnFlowGroup:
	var name
	var at_time_elapsed
	var spawn_positioning
	var events = []
	var parent
	
	func _init(name, at_time_elapsed, spawn_positioning):
		self.name = name
		self.at_time_elapsed = at_time_elapsed
		self.spawn_positioning = spawn_positioning
		
		
	func add_event(to_spawn, count, spawn_positioning = SpawnPositioning.RANDOM) -> SpawnFlowGroup:
		events.append({ "to_spawn": to_spawn, "count": count, "spawn_positioning": spawn_positioning })
		return self
		
		
	func done():
		return parent
	

var spawn_flow_data = []


func add_event(to_spawn, count, at_time_elapsed, spawn_positioning = SpawnPositioning.RANDOM) -> SpawnFlow:
	spawn_flow_data.append({ "to_spawn": to_spawn, "count": count, "at_time_elapsed": at_time_elapsed })
	return self

	
func add_group(name, at_time_elapsed, spawn_positioning = SpawnPositioning.RANDOM) -> SpawnFlowGroup:
	var current_group = SpawnFlowGroup.new(name, at_time_elapsed, spawn_positioning)
	spawn_flow_data.append(current_group)
	current_group.parent = self
	
	return current_group


func done():
	return self
