class_name PlayerCharacterSheet
extends CharacterSheet

@export var base_experience := 10

var level: int
var experience: int
var total_experience: int
var to_next_level: int
var is_selectable := true
var is_visible := true


func setup():
	super.setup()
	
	level = 1
	experience = 0
	total_experience = 0
	to_next_level = base_experience
	

func add_experience(value: int):
	# TODO: handle multiple level ups at once
	experience += value
	Events.experience_received.emit()

	if experience >= to_next_level:
		level += 1
		experience = experience - to_next_level
		to_next_level = _experience_for_level(level)
		Events.player_leveled_up.emit()


func _experience_for_level(level: int) -> int:
	return int(base_experience * pow(level, 2.5))
