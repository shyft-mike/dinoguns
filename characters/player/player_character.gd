extends Character
class_name PlayerCharacter

var level: int = 0
var next_level: int = 1
var experience: int = 0
var is_selectable := true
var is_visible := true


func add_experience(value: int):
	# TODO: handle multiple level ups at once
	experience += value

	if experience >= next_level:
		level += 1