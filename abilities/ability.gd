class_name Ability
extends Node

enum AbilityType {MOVE,FIREBALL,RAPTOR_SLASH,GENERIC_PROJECTILE_LAUNCHER}

@export var type: AbilityType

var ability_manager: AbilityManager = null
var user: Character = null


func on_ability_added() -> void:
	pass		


func execute(_options: Dictionary) -> void:
	pass
