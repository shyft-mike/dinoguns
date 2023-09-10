extends Node2D


func _ready():
	$Players.add_child(State.player)
	
	Events.time_of_day_changed.connect(_on_time_of_day_changed)
	

func _on_time_of_day_changed(new_color):
	$DirectionalLight2D.color = new_color
