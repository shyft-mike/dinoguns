extends Node2D

@export var player_character := preload("res://characters/player/player.tscn")

func _ready():
	var player_character_instance = player_character.instantiate()
	player_character_instance._character = State.selected_character
	$Players.add_child(player_character_instance)
	
	Events.time_of_day_changed.connect(_on_time_of_day_changed)
	

func _on_time_of_day_changed(new_color):
	$DirectionalLight2D.color = new_color
