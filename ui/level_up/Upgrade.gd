class_name Upgrade
extends Node

enum PowerType { FURY,MUTABILITY,RESILIENCE,PRIMAL_FORCE }

@export var title: String
@export var icon: Texture2D

@export var power_type: PowerType

@export var required_level: int = 0
@export var required_fury: int = 0
@export var required_mutability: int = 0
@export var required_resilience: int = 0
@export var required_primal_force: int = 0

@export var upgrade_stat_type: Stat.StatType
@export var upgrade_stat_value: int


func apply(player: Player, options: Object = null):
	get_parent().remove_child(self)
	player._upgrade_container.add_child(self)

	match power_type:
		PowerType.FURY:
			player.stat_manager.fury_stat_count += 1
		PowerType.MUTABILITY:
			player.stat_manager.mutability_stat_count += 1
		PowerType.RESILIENCE:
			player.stat_manager.resilience_stat_count += 1
		PowerType.PRIMAL_FORCE:
			player.stat_manager.primal_force_stat_count += 1

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
	if player.stat_manager.fury_stat_count < required_fury: return false
	if player.stat_manager.mutability_stat_count < required_mutability: return false
	if player.stat_manager.resilience_stat_count < required_resilience: return false
	if player.stat_manager.primal_force_stat_count < required_primal_force: return false

	return true


func custom_upgrade(_player: Player, _options: Object):
	pass
