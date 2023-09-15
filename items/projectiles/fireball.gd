class_name Fireball
extends Projectile

@export var initial_speed: float = 25.0
@export var lifetime: float = 3.0


func _ready():
	get_tree().create_timer(lifetime).timeout.connect(_on_lifetime_timer_timeout)
	var final_speed = speed
	speed = initial_speed
	await get_tree().create_timer(0.2).timeout
	speed = final_speed


func _on_lifetime_timer_timeout():
	if is_instance_valid(self):
		get_parent().remove_child(self)
