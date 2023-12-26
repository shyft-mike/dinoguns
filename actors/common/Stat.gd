class_name Stat
extends Resource

enum StatType {CUSTOM,ATTACK,MOVE_SPEED,HEALTH_REGEN}

@export var name: String
@export var base_value: int

var bonus_value: int = 0


static func create(stat_name: String, stat_base_value: int = 0) -> Stat:
	var result = Stat.new()
	result.name = stat_name
	result.base_value = stat_base_value
	return result


func total_value():
	return base_value + bonus_value


func _to_string():
	return "%s: %d(+%d)" % [name, base_value, bonus_value]
