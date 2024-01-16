class_name Shotgun
extends ProjectileLauncher

@export var projectiles: int = 5


func _internal_activate(user: Actor, spawn_marker: Marker2D = null) -> void:
	spawn_marker = bullet_spawn
	var direction = _get_target_direction(spawn_marker)

	for i in range(projectiles):
		var angle = randf_range(0, 2 * PI)
		var radius = randf_range(0, 5)
		var offset = Vector2(cos(angle), sin(angle)) * radius
		var direction_mod = randf_range(-PI/15, PI/15)
		_fire(user, spawn_marker.global_position + offset, direction.rotated(direction_mod))

	_eject_cartridge()
