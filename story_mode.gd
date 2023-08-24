extends Node


func _ready():
	$Panel/Player.init(Global.selected_character)
