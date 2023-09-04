extends PanelContainer


var upgrade_options = [
	{"icon": load("res://art/temp/claw.png"), "stat": "attack", "value": 10},
	{"icon": null, "stat": "speed", "value": 10},
	{"icon": null, "stat": "regen", "value": 5},
]


func _ready():
	_generate_options_list()


func _on_item_list_item_selected(index):
	var selected_item = $ItemList.get_item_metadata(index)
	
	match selected_item.stat:
		"attack":
			State.selected_character.stats.attack.add_bonus(selected_item.value)			
		"speed":
			State.selected_character.stats.move_speed.add_bonus(selected_item.value)
		"regen":
			State.selected_character.stats.health_regen.add_bonus(selected_item.value)
	
	get_tree().paused = false
	queue_free()


func _generate_options_list():
	for option in upgrade_options:
		var index = $ItemList.add_item("%s +%d" % [option.stat, option.value], option.icon)
		$ItemList.set_item_metadata(index, option)
