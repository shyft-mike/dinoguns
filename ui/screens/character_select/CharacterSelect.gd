extends Panel

@onready var stats_panel: StatsPanel = $StatsPanel
@onready var selected_character_sprite: Sprite2D = $Viewer/SelectedCharacterSprite
@onready var viewer: Node2D = $Viewer


func _ready():
	var characters = _get_characters()
	var first = true

	for character in characters:
		viewer.add_child(character)
		character.camera.enabled = false
		character.hide()

		if first:
			selected_character_sprite.texture = character._body_sprite.texture
			stats_panel.load_character(character)
			first = false


func _get_characters() -> Array[Player]:
	var results = _get_selectable_characters()

	return results


func _get_selectable_characters():
	var results = ActorFactory.get_player_characters()
	return results


func _on_character_hovered(character):
	stats_panel.load_character(character)
