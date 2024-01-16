class_name RicochetUpgrade
extends Upgrade

var modifier: RicochetModifier = RicochetModifier.new()


func custom_upgrade(player: Player, _options: Object = null):
	var uzi_ability = player._ability_container.get_node_or_null("Uzi") as ProjectileLauncher
	if uzi_ability:
		uzi_ability.attached_damager_modifiers.append(modifier)

	var shotgun_ability = player._ability_container.get_node_or_null("Shotgun") as ProjectileLauncher
	if shotgun_ability:
		shotgun_ability.attached_damager_modifiers.append(modifier)
