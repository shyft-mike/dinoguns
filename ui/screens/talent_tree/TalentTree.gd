extends Control

const TALENT_STATE_PATH: String = "user://talent_state.dat"


func _ready() -> void:
	Events.talent_updated.connect(_on_talent_updated)


func _on_talent_updated(talent_button: TalentButton):
	_update_available_skills(talent_button)


func _update_available_skills(root_talent_node: TalentButton):
	var talent_nodes = root_talent_node.get_children()

	for talent_node in talent_nodes:
		if talent_node is TalentButton:
			var disable_talent = root_talent_node.talent.level == 0
			talent_node.talent.set_disabled(disable_talent)
			if disable_talent:
				talent_node.disable_children()


func _load_talents() -> void:
	pass
	#var talent_file = FileAccess.open(TALENT_STATE_PATH, FileAccess.READ)
	#if talent_file:
		#print_debug(talent_file.get_pascal_string())
	#else:
		#talents = TalentState.new()


func _save_talents() -> void:
	pass
	#var talent_file = FileAccess.open(TALENT_STATE_PATH, FileAccess.WRITE)
	#var content = JSON.stringify(talents)
	#print_debug(content)
	#talent_file.store_pascal_string(JSON.stringify(talents))


func _get_talent_state():
	var talent_buttons = get_tree().get_nodes_in_group("talent")

	return talent_buttons.map(func(talent_button): return talent_button.talent.to_dict())


func _set_talent_state(loaded_talents: Array):
	var talent_buttons = get_tree().get_nodes_in_group("talent")

	for loaded_talent in loaded_talents:
		for talent_button in talent_buttons as Array[TalentButton]:
			if loaded_talent.name == talent_button.talent.name:
				talent_button.set_level(loaded_talent.level)

	_update_available_skills(talent_buttons[0])


func _on_save_button_pressed() -> void:
	var talents = _get_talent_state()
	var talent_file = FileAccess.open(TALENT_STATE_PATH, FileAccess.WRITE)
	talent_file.store_var(talents)


func _on_load_button_pressed() -> void:
	var talent_file = FileAccess.open(TALENT_STATE_PATH, FileAccess.READ)
	var loaded_talents = talent_file.get_var()
	_set_talent_state(loaded_talents)
