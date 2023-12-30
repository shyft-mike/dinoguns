class_name PlayerStatManager
extends ActorStatManager


@export var base_experience: int = 10

var level: int = 0
var experience: int = 0
var total_experience: int = 0
var to_next_level: int = base_experience

var current_upgrades: Array[Upgrade] = []
var fury_stat_count: int = 0
var mutability_stat_count: int = 0
var resilience_stat_count: int = 0
var primal_force_stat_count: int = 0


func setup():
	super.setup()

	level = 0
	experience = 0
	total_experience = 0
	to_next_level = base_experience
	current_upgrades = []
	fury_stat_count = 0
	mutability_stat_count = 0
	resilience_stat_count = 0
	primal_force_stat_count = 0

	Events.player_health_changed.emit(0)
	Events.experience_received.emit()


func take_damage(damage: DamageService.Damage) -> int:
	var damage_taken = super.take_damage(damage)

	Events.player_health_changed.emit(-damage_taken)

	return damage_taken


## Causes the character to regenerate health.
func regen() -> int:
	var health_regened = super.regen()

	if health_regened > 0:
		Events.player_health_changed.emit(health_regened)

	return health_regened


func add_experience(value: int):
	# TODO: handle multiple level ups at once

	experience += value
	Events.experience_received.emit()

	if experience >= to_next_level:
		level += 1
		experience = experience - to_next_level
		to_next_level = _experience_for_level(base_experience, level)
		Events.player_leveled_up.emit()


func _experience_for_level(base_experience: int, level: int) -> int:
	return int(base_experience * pow(level, 2.5))

