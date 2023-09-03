extends Node


func _ready():
	Events.character_selected.connect(_on_character_selected)
	

func start():
	SceneManager.change_scene(SceneManager.LEVEL_1_SCENE)
	TimeManager.reset()
	TimeManager.start()

	
func _on_character_selected(character):
	State.selected_character = character
	start()
