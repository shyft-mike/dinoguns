extends Node

const COMPY_TEMPLATE: PackedScene = preload("res://actors/enemies/compy/Compy.tscn")


func spawn(at: Vector2 = Vector2.ZERO):
	var enemy: Enemy
	enemy = Pooling.get_from_pool(
		Pooling.PoolType.COMPY,
		func(): return COMPY_TEMPLATE.instantiate())

	if at == Vector2.ZERO:
		enemy.position = _get_random_spawn_location()
	else:
		enemy.position = at

	SceneManager.current_scene.spawns_container.add_child(enemy)
	enemy.setup()


func _get_random_spawn_location() -> Vector2:
	return State.player.position + Vector2(randi_range(1000, 1000), 0).rotated(randf_range(0, 2*PI))
