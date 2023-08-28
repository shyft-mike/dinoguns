extends RefCounted
class_name CharacterStats

var health = Stat.new()
var special = Stat.new()
var attack = Stat.new()
var defense = Stat.new()
var attack_speed = Stat.new()
var move_speed = Stat.new()


func calc_move_speed(standard_move_speed: int) -> float:
	var player_speed = move_speed.total_value()
	var speed_diff = player_speed - 10
	
	return standard_move_speed + (standard_move_speed * (speed_diff * 4 / 100))
