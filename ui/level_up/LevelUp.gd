extends PanelContainer

@onready var upgrade_item_list: ItemList = $UpgradeItemList
@onready var general_upgrades: Node = $GeneralUpgrades
@onready var gun_upgrades: Node = $GunUpgrades
@onready var raptor_upgrades: Node = $RaptorUpgrades


func _init():
	tree_exited.connect(_on_hide)


func setup():
	_generate_options_list()


func _on_hide():
	upgrade_item_list.clear()


func _on_item_list_item_selected(index):
	var selected_item = upgrade_item_list.get_item_metadata(index) as Upgrade

	selected_item.apply(State.player)

	get_parent().call_deferred("remove_child", self)
	get_tree().paused = false


func _generate_options_list():
	var upgrade_options = _get_available_upgrades()
	for option in upgrade_options:
		var index = upgrade_item_list.add_item(option.title, option.icon)
		upgrade_item_list.set_item_metadata(index, option)
		upgrade_item_list.set_item_custom_bg_color(index, get_item_bg_color(option))


func _get_available_upgrades() -> Array[Upgrade]:
	var results: Array[Upgrade] = []

	for upgrade in general_upgrades.get_children() as Array[Upgrade]:
		if upgrade.is_selectable(State.player):
			results.append(upgrade)

	for upgrade in gun_upgrades.get_children() as Array[Upgrade]:
		if upgrade.is_selectable(State.player):
			results.append(upgrade)

	return results


func get_item_bg_color(upgrade: Upgrade):
	match upgrade.power_type:
		Upgrade.PowerType.FURY:
			return Color.RED
		Upgrade.PowerType.MUTABILITY:
			return Color.YELLOW
		Upgrade.PowerType.RESILIENCE:
			return Color.GREEN
		Upgrade.PowerType.PRIMAL_FORCE:
			return Color.SKY_BLUE
