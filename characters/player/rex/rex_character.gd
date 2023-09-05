extends PlayerCharacter
class_name Rex


func _init():
	name = "Rex"
	is_selectable = false
	is_visible = true
	
	stats.attack.init(15)
	stats.defense.init(10)
	stats.health.init(140)
	stats.special.init(8)
	stats.attack_speed.init(5)
	stats.move_speed.init(5)	
