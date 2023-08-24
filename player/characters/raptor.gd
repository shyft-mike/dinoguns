extends Character
class_name Raptor


func _init():
	name = "Raptor"
	icon = load("res://art/characters/RAPTOR_icon_64x64.png")
	is_selectable = true
	is_visible = true
	
	stats.attack.set_base_value(10)
	stats.defense.set_base_value(7)
	stats.health.set_base_value(90)
	stats.speed.set_base_value(15)
	stats.special.set_base_value(7)
