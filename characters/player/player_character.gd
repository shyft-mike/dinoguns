extends Character
class_name PlayerCharacter

@export var base_experience := 10

var level: int = 1
var experience: int = 0
var total_experience: int = 0
var to_next_level: int = base_experience
var is_selectable := true
var is_visible := true


func add_experience(value: int):
	# TODO: handle multiple level ups at once
	experience += value
	Events.experience_received.emit(value)

	if experience >= to_next_level:
		print_debug(" ".join(["add_experience()",level, experience, to_next_level]))
		level += 1
		experience = experience - to_next_level
		to_next_level = _experience_for_level(level)		
		Events.player_leveled_up.emit()


func _experience_for_level(level: int) -> int:
	return int(base_experience * pow(level, 2.5))
