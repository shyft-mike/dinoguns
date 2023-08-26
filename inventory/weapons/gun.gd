extends Node2D

@export var projectile_scene: PackedScene
@export var fire_rate := 3
@export var bullet_life := 3


func _ready():
	$Timer.wait_time = 1.0 / fire_rate


func _draw():
	draw_circle(Vector2(0, 0), 4, Color.RED)


func _on_timer_timeout():
	fire()
	
	
func fire():
	var projectile = projectile_scene.instantiate() as Node2D
	projectile.global_position = self.global_position
	projectile.direction = (get_global_mouse_position() - global_position).normalized()
	projectile.rotation = projectile.direction.angle()
	
	# have to attach it here or your bullets rotate with you @_@
	get_tree().get_root().add_child(projectile)	
	
	await get_tree().create_timer(bullet_life).timeout
	
	projectile.queue_free()
