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


func apply(player: Player, options = {}):
	player.current_upgrades.append(self)
	
	if upgrade_stat_type != null:
		match upgrade_stat_type:
			Stat.StatType.ATTACK:
				player.attack.bonus_value += upgrade_stat_value
			Stat.StatType.MOVE_SPEED:
				player.move_speed.bonus_value += upgrade_stat_value
			Stat.StatType.HEALTH_REGEN:
				player.health_regen.bonus_value += upgrade_stat_value
	else:
		custom_upgrade(options)


func is_selectable(player: Player):
	if player.level < required_level: return false
	if player.rage_stat_count < required_rage: return false
	if player.adaptation_stat_count < required_adaptation: return false
	if player.metabolism_stat_count < required_metabolism: return false
	if player.primal_stat_count < required_primal: return false
	
	return true


func custom_upgrade(_options):
	pass
