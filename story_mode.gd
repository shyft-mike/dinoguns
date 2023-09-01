extends Node2D


func _ready():
	$SubViewportContainer/SubViewport/Panel/Player._character = State.selected_character
