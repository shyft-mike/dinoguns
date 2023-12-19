extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func get_collision_shape():
	return collision_shape.shape
