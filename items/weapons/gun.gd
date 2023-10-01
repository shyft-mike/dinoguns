extends Node2D

@export var thumbnail_texture: Texture2D
@export var projectile_scene: PackedScene
@export var fire_rate := 10
@export var bullet_life := 3
@export var effective_range := 500.0


func _ready():
	$RangeArea/CollisionShape2D.shape.radius = effective_range
	$Timer.wait_time = 1.0 / fire_rate


func _on_timer_timeout():
	var target = _pick_target()
	
	if target:
		fire_at(target.global_position)
	else:
		fire_at(get_global_mouse_position())
		
	
func _pick_target():
	var nodes_in_range = $RangeArea.get_overlapping_bodies()
	
	if nodes_in_range.size() > 0:
		return nodes_in_range[randi() % nodes_in_range.size()]	


func fire_at(location: Vector2):
	var projectile = Pooling.get_from_pool(Pooling.PoolType.BULLET, func(): return projectile_scene.instantiate())
	
	projectile.global_position = self.global_position
	projectile.direction = (location - global_position).normalized()
	projectile.rotation = projectile.direction.angle()
	
	# have to attach it here or your bullets rotate with you @_@
	get_tree().get_root().add_child(projectile)	
	
	await get_tree().create_timer(bullet_life).timeout
	
	projectile.remove()

