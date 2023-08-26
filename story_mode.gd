extends Node


func _ready():
	$Panel/Player.init(State.selected_character)
