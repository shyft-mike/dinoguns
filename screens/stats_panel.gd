extends Panel
class_name StatsPanel


func load_character(character: Character):
	$VBoxContainer/HealthLabel.set_text(
		"Health: %d(+%d)" % 
		[
			character.stats.health.base_value, 
			character.stats.health.bonus_value
		])
	
	
