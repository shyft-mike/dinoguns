class_name FireModifier
extends Modifier


func modify_damager(damager: Damager) -> void:
	damager.set_damage_type(DamageService.DamageType.FIRE)
