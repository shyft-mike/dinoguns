extends Node

const CHARACTER_SELECT_SCENE_PATH = "res://screens/character_select/character_select.tscn"


func _on_start_button_pressed():
	SceneManager.change_scene(CHARACTER_SELECT_SCENE_PATH)
