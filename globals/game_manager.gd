extends Node


func _ready():
	Events.character_selected.connect(_on_character_selected)
	
	
func _on_character_selected(character):
	State.selected_character = character
	SceneManager.change_scene("res://story_mode.tscn")
	TimeManager.reset().start()
