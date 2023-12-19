class_name AbilityManager
extends Node

var abilities: Dictionary = {}


func _ready():
	await owner.ready
	
	for ability in get_children():
		_register_ability(ability)
	
	child_entered_tree.connect(_on_ability_added)


func add_ability(ability: Ability):
	call_deferred("add_child", ability)


func _register_ability(ability: Ability):
	ability.user = owner
	ability.ability_manager = self
	abilities[ability.type] = ability


func execute(ability_type: Ability.AbilityType, options = {}):
	return abilities.get(ability_type).execute(options)


func _on_ability_added(ability: Ability):
	_register_ability(ability)
	ability.on_ability_added()
