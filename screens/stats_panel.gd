extends Panel
class_name StatsPanel


func load_character(character: CharacterSheet):
	$VBoxContainer/HealthLabel.set_text(character.stats.health.to_string())
