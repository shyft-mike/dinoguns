extends Character
class_name Rex


func _init():
	name = "Rex"
	is_selectable = false
	is_visible = true
	
	stats.attack.set_base_value(15)
	stats.defense.set_base_value(10)
	stats.health.set_base_value(140)
	stats.speed.set_base_value(5)
	stats.special.set_base_value(8)
