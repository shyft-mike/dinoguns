class_name StatsPanel extends Panel

@onready var stat_label_template: Label = $MarginContainer/VBoxContainer/StatLabelTemplate
@onready var stat_container: VBoxContainer = $MarginContainer/VBoxContainer


func load_character(character: Player):
	add_stat_label(character.stat_manager.health)
	add_stat_label(character.stat_manager.attack)
	add_stat_label(character.stat_manager.defense)
	add_stat_label(character.stat_manager.move_speed)


func add_stat_label(stat: Stat):
	var label: Label = stat_label_template.duplicate()
	label.set_text(stat.name + ": " + str(stat.base_value) + "(+" + str(stat.bonus_value) + ")")
	stat_container.add_child(label)
	label.show()
