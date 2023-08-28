extends Node


func _ready():
	$Panel/Player._character = State.selected_character
