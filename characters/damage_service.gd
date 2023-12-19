class_name DamageService
extends RefCounted


enum DamageType {PHYSICAL,FIRE,UNSTOPPABLE}


class Damage:
	var type: DamageType
	var amount: int
		
	func _init(damage_type: DamageType, damage_amount: int):
		type = damage_type
		amount = damage_amount


static func calc_damage(character: Character, damage: Damage):
	var actual_damage: int
	
	match damage.type:
		DamageType.PHYSICAL:
			if character.defense.total_value() > damage.amount:
				actual_damage = 1
			else:
				actual_damage = damage.amount - character.defense.total_value()
		DamageType.FIRE:
			actual_damage = _calc_elemental_damage(character.fire_resist.total_value(), damage.amount)
		DamageType.UNSTOPPABLE:
			actual_damage = damage.amount
			
	return actual_damage


static func _calc_elemental_damage(resistance, damage_amount: int):
	# Resistance gives a 1:1 percent chance of complete resist
	if randf() <= resistance / 100:
		return 0
		
	return damage_amount * resistance
	
