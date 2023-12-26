class_name DamageService
extends RefCounted


enum DamageType {PHYSICAL,FIRE,UNSTOPPABLE}


class Damage:
	var damage_type: DamageType
	var base_damage: int

	func _init(damage_type: DamageType, base_damage: int):
		self.damage_type = damage_type
		self.base_damage = base_damage


static func calc_damage(stat_manager: ActorStatManager, damage: Damage) -> int:
	var actual_damage: int

	match damage.damage_type:
		DamageType.PHYSICAL:
			if stat_manager.defense.total_value() > damage.base_damage:
				actual_damage = 1
			else:
				actual_damage = damage.base_damage - stat_manager.defense.total_value()
		DamageType.FIRE:
			actual_damage = _calc_elemental_damage(
				stat_manager.fire_resist.total_value(),
				damage.base_damage
			)
		DamageType.UNSTOPPABLE:
			actual_damage = damage.base_damage

	return actual_damage


static func _calc_elemental_damage(resistance: int, damage_amount: int) -> int:
	# Resistance gives a 1:1 percent chance of complete resist
	if randf() <= resistance / 100:
		return 0

	return damage_amount * resistance

