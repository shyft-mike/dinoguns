extends Node

const MAIN_SCENE_PATH = "res://screens/character_select/character_select.tscn"


func _on_start_button_pressed():
	Global.change_scene(MAIN_SCENE_PATH)
