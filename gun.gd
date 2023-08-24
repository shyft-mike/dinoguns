extends Node2D

signal fire

@export var projectile_scene: PackedScene


func _draw():
	draw_circle(Vector2(12, 0), 4, Color.RED)


func _on_timer_timeout():
	var projectile = projectile_scene.instantiate()	
	var new_point = get_global_mouse_position()
	
	var coll = projectile.get_child(0)
	var line = projectile.get_child(1)
	
	line.add_point(new_point)
	
	var new_coll = coll.duplicate()
	var new_shape = coll.shape.duplicate()
	new_coll.shape = new_shape
	new_coll.shape.a = position
	new_coll.shape.b = new_point
	
	add_child(new_coll, true)
	
	await get_tree().create_timer(0.2).timeout
	
	new_coll.queue_free()
