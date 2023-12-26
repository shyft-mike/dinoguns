extends PanelContainer

@onready var upgrade_item_list: ItemList = $UpgradeItemList
@onready var upgrade_container: Node = $UpgradeContainer


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
	var upgrade_options = upgrade_container.get_children() as Array[Upgrade]
	for option in upgrade_options:
		if option.is_selectable(State.player):
			var index = upgrade_item_list.add_item(option.title, option.icon)
			upgrade_item_list.set_item_metadata(index, option)
			upgrade_item_list.set_item_custom_bg_color(index, get_item_bg_color(option))


func get_item_bg_color(upgrade: Upgrade):
	match upgrade.power_type:
		Upgrade.PowerType.RAGE:
			return Color.RED
		Upgrade.PowerType.ADAPTATION:
			return Color.YELLOW
		Upgrade.PowerType.METABOLISM:
			return Color.GREEN
		Upgrade.PowerType.PRIMAL:
			return Color.SKY_BLUE
