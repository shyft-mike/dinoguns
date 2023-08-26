extends RigidBody2D

@export var speed := 300

var direction := Vector2.ZERO

func _process(delta):
	move_and_collide(direction * speed * delta)
