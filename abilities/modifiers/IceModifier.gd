class_name IceModifier
extends Modifier


func modify_damager(damager: Damager) -> void:
	damager.set_damage_type(DamageService.DamageType.ICE)
	damager.get_node("Sprite2D").modulate = Color.SKY_BLUE
