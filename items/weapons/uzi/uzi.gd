extends Item

@export var uzi_ability: PackedScene = preload("res://abilities/uzi/uzi.tscn")


func pickup():
	State.player.abilities.add_ability(uzi_ability.instantiate())
	remove()
