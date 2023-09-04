extends Node


func _ready():
	Events.character_selected.connect(_on_character_selected)
	Events.player_leveled_up.connect(_on_player_leveled_up)

func start():
	SceneManager.change_scene(SceneManager.LEVEL_1_SCENE)
	TimeManager.reset()
	TimeManager.start()

	
func _on_character_selected(character):
	State.selected_character = character
	start()


func _on_player_leveled_up():
	var level_up_scene = ResourceLoader.load(SceneManager.LEVEL_UP_SCENE).instantiate()
	SceneManager.current_scene.get_node("UILayer").add_child(level_up_scene)
	get_tree().paused = true
	
