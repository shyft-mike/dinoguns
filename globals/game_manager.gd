extends Node


func _ready():
	Events.character_selected.connect(_on_character_selected)
	Events.player_leveled_up.connect(_on_player_leveled_up)


func start():
	SceneManager.change_scene(
		SceneManager.LEVEL_1_SCENE, 
		func(): SceneManager.current_scene.players_container.add_child(State.player))
	TimeManager.reset()
	TimeManager.start()
	get_tree().paused = false


func game_over():
	get_tree().paused = true
	SceneManager.current_scene.remove_child(State.player)
	SceneManager.change_scene(SceneManager.GAME_OVER_SCENE)

	
func _on_character_selected(new_player):
	State.player = new_player
	State.player.is_player = true
	start()


func _on_player_leveled_up():
	var level_up_scene = ResourceLoader.load(SceneManager.LEVEL_UP_SCENE).instantiate()
	SceneManager.current_scene.get_node("UILayer").add_child(level_up_scene)
	get_tree().paused = true
	
