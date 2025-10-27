extends Panel

@onready var stats_panel: StatsPanel = $StatsPanel
@onready var selected_character_sprite: Sprite2D = $Viewer/SelectedCharacterSprite
@onready var viewer: Node2D = $Viewer

var _selected_character: Player

func _ready():
	var characters: Array[Player] = _get_characters()
	var first = true

	for character in characters:
		viewer.add_child(character)
		character.camera.enabled = false
		character.hide()

		if first:
			_selected_character = character
			selected_character_sprite.texture = character._body_sprite.texture
			selected_character_sprite.vframes = character._body_sprite.vframes
			stats_panel.load_character(character)
			first = false


func _get_characters() -> Array[Player]:
	var results = _get_selectable_characters()
	return results


func _get_selectable_characters() -> Array[Player]:
	var results = ActorFactory.get_player_characters()
	return results


func _on_character_hovered(character):
	stats_panel.load_character(character)


func _on_start_button_pressed() -> void:
	viewer.remove_child(_selected_character)
	Events.character_selected.emit(_selected_character)
