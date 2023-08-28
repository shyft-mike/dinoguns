extends Node2D
class_name Item

enum ItemType {WEAPON,POWERUP,PICKUP}

var type: ItemType
var player_to_move_to: Node2D

func _process(delta):
	if player_to_move_to:
		global_position = global_position.move_toward(player_to_move_to.global_position, delta * 100)
		rotate(deg_to_rad(10) * delta * 40)


func on_pickup():
	pass
