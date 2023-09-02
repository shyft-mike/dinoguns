extends EnemyCharacter
class_name Compy

func _init():
	drops.append(preload("res://inventory/pickups/gene.tscn").instantiate())
	
	name = "Compy"
	stats.attack.init(5)
	stats.defense.init(3)
	stats.health.init(20)
	stats.current_health = stats.health.total_value()
	stats.special.init(5)
	stats.move_speed.init(7)
	stats.attack_speed.init(7)
