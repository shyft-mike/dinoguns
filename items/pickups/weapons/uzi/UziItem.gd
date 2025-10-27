extends Item

static var uzi_ability_template = preload("res://abilities/instances/uzi/Uzi.tscn")


func pickup():
	State.player.add_ability(uzi_ability_template.instantiate())
	remove()
