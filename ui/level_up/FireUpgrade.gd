class_name FireUpgrade
extends Upgrade

var modifier: FireModifier = FireModifier.new()


func custom_upgrade(player: Player, _options: Object = null):
	var uzi_ability = player._ability_container.get_node_or_null("Uzi") as ProjectileLauncher
	if uzi_ability:
		uzi_ability.attached_modifiers.append(modifier)
