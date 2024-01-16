class_name ProjectileLauncher
extends Ability

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var range_area: Area2D = $RangeArea
@onready var range_area_collision: CollisionShape2D = $RangeArea/CollisionShape2D
@onready var bullet_spawn: Marker2D = $BulletSpawn
@onready var shell_spawn: Marker2D = $ShellSpawn

@export var autofire: bool = false
@export var thumbnail_texture: Texture2D
@export var cartridge_template: PackedScene
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


func _get_target_direction(spawn_marker: Marker2D):
	var target_position

	if autofire:
		var nodes_in_range = range_area.get_overlapping_bodies()
		if nodes_in_range.size() > 0:
			target_position = nodes_in_range.pick_random().global_position
	else:
		target_position = spawn_marker.get_global_mouse_position()

	return spawn_marker.global_position.direction_to(target_position)


func _internal_activate(user: Actor, spawn_marker: Marker2D = null) -> void:
	spawn_marker = bullet_spawn
	if shots_fired == 15:
		var center_position = spawn_marker.global_position
		var radius_vector = Vector2(100, 0)
		for i in range(1, 21):
			var target_position = center_position + radius_vector.rotated(((PI * 2) / 20) * i)
			var target_direction = spawn_marker.global_position.direction_to(target_position)
			_fire(user, spawn_marker.global_position, target_direction)
			_eject_cartridge()
			await get_tree().create_timer(multishot_delay).timeout
		shots_fired = 0
	else:
		var direction = _get_target_direction(spawn_marker)
		_fire(user, spawn_marker.global_position, direction)
		_eject_cartridge()


func _fire(user: Actor, spawn_position: Vector2, direction: Vector2):
	shots_fired += 1
	var projectile = ProjectileFactory.generate(projectile_type)

	for modifier in attached_modifiers:
		modifier.modify_damager(projectile)

	for modifier in attached_damager_modifiers:
		projectile.attached_modifiers.append(modifier)

	projectile.position = spawn_position
	projectile.direction = direction
	projectile.rotation = direction.angle()
	projectile.lifetime = bullet_life
	projectile.user = user

	get_tree().get_root().add_child(projectile)

	if fire_sound:
		audio_stream_player.play()


func _eject_cartridge() -> void:
	if cartridge_template:
		var cartridge: Item = cartridge_template.instantiate()
		cartridge.global_position = shell_spawn.global_position
		SceneManager.current_scene.items_container.call_deferred("add_child", cartridge)
		cartridge.call_deferred("launch")
