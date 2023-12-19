extends PanelContainer

@onready var upgrade_item_list: ItemList = $UpgradeItemList
@onready var upgrade_options: Array[Node] = $Upgrades.get_children()


func _ready():
	_generate_options_list()


func _on_item_list_item_selected(index):
	var selected_item = upgrade_item_list.get_item_metadata(index) as Upgrade

	selected_item.apply(State.player)
		
	get_tree().paused = false
	queue_free()


func _generate_options_list():
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
