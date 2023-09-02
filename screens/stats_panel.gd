extends Panel
class_name StatsPanel


func load_character(character: Character):
	$VBoxContainer/HealthLabel.set_text(character.stats.health.to_string())
