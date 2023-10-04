class_name Fireball
extends Node


@export var fireball_template := preload("res://items/projectiles/fireball.tscn")


func execute(spawn_location: Vector2, direction: Vector2, speed: float = 25.0, lifetime: float = 3.0):
	var fireball = fireball_template.instantiate()
	fireball.global_position = spawn_location
	fireball.direction = direction
	fireball.lifetime = lifetime
	fireball.speed = speed
	get_node("/root").add_child(fireball)
