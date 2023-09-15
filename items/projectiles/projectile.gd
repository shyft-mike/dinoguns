class_name Projectile
extends Area2D

@export var speed: float = 300.0
@export var damage: int = 2

var direction := Vector2.ZERO


func _process(delta):
	position += (direction.normalized() * speed * delta)


func _on_body_entered(body):
	var parent = body.get_parent()
	if parent is Enemy:
		parent.take_damage(damage)


func remove():
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)
