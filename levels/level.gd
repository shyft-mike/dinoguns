extends Node2D

@export var player_character := preload("res://characters/player/player.tscn")

func _ready():
	var player_character_instance = player_character.instantiate()
	player_character_instance._character = State.selected_character
	$Players.add_child(player_character_instance)
