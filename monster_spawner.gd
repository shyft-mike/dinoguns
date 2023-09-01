extends Node2D


func _on_timer_timeout():
	var enemy = load("res://enemy.tscn").instantiate()
	add_child(enemy)
	
