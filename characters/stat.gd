extends RefCounted
class_name Stat

var _base_value: int = 0
var _bonus_value: int = 0


func init(base_value: int, bonus_value: int = 0):
	_base_value = base_value
	_bonus_value = bonus_value


func total_value():
	return _base_value + _bonus_value


func set_base_value(value):
	_base_value = value


func add_bonus(amount):
	_bonus_value += amount


func remove_bonus(amount):
	_bonus_value -= amount


func _to_string():
	return "Health: %d(+%d)" % [_base_value, _bonus_value]
