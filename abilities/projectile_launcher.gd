class_name ProjectileLauncher
extends Ability

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var range_area: Area2D = $RangeArea
@onready var range_area_collision: CollisionShape2D = $RangeArea/CollisionShape2D
@onready var shot_timer: Timer = $ShotTimer

@export var thumbnail_texture: Texture2D
@export var projectile_type: Projectile.ProjectileType
@export var fire_rate := 10
@export var bullet_life := 3
@export var effective_range := 500.0
@export var fire_sound: AudioStream

var position_marker: Marker2D

func _ready():
	type = AbilityType.GENERIC_PROJECTILE_LAUNCHER
	
	if fire_sound:
		audio_stream_player.stream = fire_sound
	
	range_area_collision.shape.radius = effective_range
	
	shot_timer.wait_time = 1.0 / fire_rate
	shot_timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	var target = _pick_target()
	
	if target:
		fire_at(target.global_position)
	else:
		fire_at(user.get_global_mouse_position())
		
	
func _pick_target():
	var nodes_in_range = range_area.get_overlapping_bodies()
	
	if nodes_in_range.size() > 0:
		return nodes_in_range[randi() % nodes_in_range.size()]	


func fire_at(location: Vector2):
	var projectile = ProjectileFactory.generate(projectile_type)
	
	# have to attach it here or your bullets rotate with you @_@
	get_tree().get_root().add_child(projectile)
	projectile.global_position = position_marker.global_position
	projectile.direction = (location - position_marker.global_position).normalized()
	projectile.rotation = projectile.direction.angle()
	projectile.lifetime = bullet_life
	projectile.setup()
	
	if fire_sound:
		audio_stream_player.play()
		

func on_ability_added():
	position_marker = user.main_ability_marker
