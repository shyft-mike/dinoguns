extends Character
class_name PlayerCharacter

@export var base_experience := 10

var level: int = 1
var experience: int = 0
var to_next_level: int = base_experience
var is_selectable := true
var is_visible := true


func add_experience(value: int):
	# TODO: handle multiple level ups at once
	experience += value

	if experience >= to_next_level:
		level += 1
		to_next_level = _experience_for_level(level)
		experience = 0
		Events.player_leveled_up.emit()


func _experience_for_level(level: int) -> int:
	return int(base_experience * pow(level, 2.5))
