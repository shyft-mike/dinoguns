class_name ProjectileLauncher
extends Ability

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var range_area: Area2D = $RangeArea
@onready var range_area_collision: CollisionShape2D = $RangeArea/CollisionShape2D

@export var thumbnail_texture: Texture2D
@export var projectile_type: ProjectileFactory.ProjectileType
@export var bullet_life := 3
@export var effective_range := 500.0
@export var fire_sound: AudioStream

var shots_fired: int = 0
var multishot_delay: float = 0.03


func _ready():
	if fire_sound:
		audio_stream_player.stream = fire_sound

	range_area_collision.shape.radius = effective_range


func _get_target_direction(spawn_position: Vector2):
	var nodes_in_range = range_area.get_overlapping_bodies()
	var target_position

	if nodes_in_range.size() > 0:
		target_position = nodes_in_range[0].global_position
	else:
		target_position = spawn_position + Vector2(100, 0)

	return spawn_position.direction_to(target_position)


func _internal_activate(user: Actor, spawn_marker: Marker2D) -> void:
	if shots_fired == 15:
		var center_position = spawn_marker.global_position
		var radius_vector = Vector2(100, 0)
		for i in range(1, 21):
			var target_position = center_position + radius_vector.rotated(((PI * 2) / 20) * i)
			var target_direction = spawn_marker.global_position.direction_to(target_position)
			_fire(user, spawn_marker.global_position, target_direction)
			await get_tree().create_timer(multishot_delay).timeout
		shots_fired = 0
	else:
		var direction = _get_target_direction(spawn_marker.global_position)
		_fire(user, spawn_marker.global_position, direction)


func _fire(user: Actor, spawn_position: Vector2, direction: Vector2):
	shots_fired += 1
	var projectile = ProjectileFactory.generate(projectile_type)

	for attached_damager_modifier in attached_damager_modifiers:
		projectile.attached_modifiers.append(attached_damager_modifier)

	get_tree().get_root().add_child(projectile)
	projectile.position = spawn_position
	projectile.direction = direction
	projectile.rotation = direction.angle()
	projectile.lifetime = bullet_life
	projectile.user = user

	if fire_sound:
		audio_stream_player.play()
