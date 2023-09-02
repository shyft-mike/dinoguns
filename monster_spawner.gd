extends Node2D


func _on_timer_timeout():
	var enemy = load("res://characters/enemies/enemy.tscn").instantiate()
	enemy.character = CharacterFactory.generate_character(CharacterFactory.CharacterType.COMPY)
	add_child(enemy)
	
