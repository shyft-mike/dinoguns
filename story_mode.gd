extends Node2D


func _ready():
	$Player._character = State.selected_character
