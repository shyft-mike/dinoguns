extends Node


func spawn(type: int):
	var enemy: Enemy
	match type:
		CharacterFactory.CharacterType.COMPY:
			enemy = Pooling.get_from_pool(
				Pooling.PoolType.COMPY, 
				func(): return CharacterFactory.generate_character_template(type).instantiate())
			
		CharacterFactory.CharacterType.MEGA_COMPY:
			enemy = CharacterFactory.generate_character_template(type).instantiate()
	
	enemy.character = CharacterFactory.generate_character_sheet(type)	
	enemy.position = _get_spawn_location()
	
	get_tree().get_first_node_in_group("spawner").add_child(enemy)
	

func _get_spawn_location() -> Vector2:
	return State.player.position + Vector2(1000, 0).rotated(randf_range(0, 2*PI))
