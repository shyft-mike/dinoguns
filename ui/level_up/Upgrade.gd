class_name Upgrade
extends Node

enum PowerType { RAGE,ADAPTATION,METABOLISM,PRIMAL }

@export var title: String
@export var icon: Texture2D

@export var power_type: PowerType

@export var required_level: int = 0
@export var required_rage: int = 0
@export var required_adaptation: int = 0
@export var required_metabolism: int = 0
@export var required_primal: int = 0

@export var upgrade_stat_type: Stat.StatType
@export var upgrade_stat_value: int


func apply(player: Player, options: Object = null):
	get_parent().remove_child(self)
	player._upgrade_container.add_child(self)

	if upgrade_stat_type == Stat.StatType.CUSTOM:
		custom_upgrade(player, options)
	else:
		match upgrade_stat_type:
			Stat.StatType.ATTACK:
				player.stat_manager.attack.bonus_value += upgrade_stat_value
			Stat.StatType.MOVE_SPEED:
				player.stat_manager.move_speed.bonus_value += upgrade_stat_value
			Stat.StatType.HEALTH_REGEN:
				player.stat_manager.health_regen.bonus_value += upgrade_stat_value


func is_selectable(player: Player):
	if player.stat_manager.level < required_level: return false
	if player.stat_manager.rage_stat_count < required_rage: return false
	if player.stat_manager.adaptation_stat_count < required_adaptation: return false
	if player.stat_manager.metabolism_stat_count < required_metabolism: return false
	if player.stat_manager.primal_stat_count < required_primal: return false

	return true


func custom_upgrade(_player: Player, _options: Object):
	pass
