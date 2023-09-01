extends Node3D


func _ready():
	var dialogue = load("res://characters/player/raptor.dialogue")
	
	$ExampleBalloon.start(dialogue, "start")
