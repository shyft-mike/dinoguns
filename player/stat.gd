extends RefCounted
class_name Stat

var base_value : int = 0
var bonus_value : int = 0


func total_value():
	return base_value + bonus_value

func set_base_value(value):
	base_value = value

func add_bonus(amount):
	bonus_value += amount

func remove_bonus(amount):
	bonus_value -= amount
