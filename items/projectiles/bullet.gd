extends Area2D

@export var speed := 300

var direction := Vector2.ZERO


func _process(delta):
	position += (direction * speed * delta)


func _on_body_entered(body):
	if body is Enemy:
		body.take_damage(2)


func remove():
	if is_inside_tree():
		get_parent().remove_child(self)
