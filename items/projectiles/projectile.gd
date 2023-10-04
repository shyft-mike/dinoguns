class_name Projectile
extends Area2D

@export var speed: float = 300.0
@export var damage: float = 2.0
@export var lifetime: float = 3.0

var direction: Vector2 = Vector2.ZERO


func _ready():
	get_tree().create_timer(lifetime).timeout.connect(_on_lifetime_timer_timeout)


func _on_lifetime_timer_timeout():
	remove()


func _physics_process(delta):
	position += (direction * speed * delta)


func _on_body_entered(body):
	var parent = body.get_parent()
	if parent is Enemy:
		parent.take_damage(damage)


func remove():
	if is_instance_valid(self) and is_inside_tree():
		get_node("/root").remove_child(self)
