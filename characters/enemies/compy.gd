extends EnemyCharacter
class_name Compy

func _init():
	drops.append(preload("res://inventory/pickups/gene.tscn").instantiate())
	
	name = "Compy"
	stats.attack.set_base_value(5)
	stats.defense.set_base_value(3)
	stats.health.set_base_value(20)
	stats.special.set_base_value(5)
	stats.move_speed.set_base_value(7)
	stats.attack_speed.set_base_value(7)
