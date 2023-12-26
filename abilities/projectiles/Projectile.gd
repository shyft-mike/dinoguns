class_name Projectile
extends Damager

@export var speed: float = 300.0
@export var lifetime: float = 3.0
@export var impact_sound: AudioStream

var direction: Vector2 = Vector2.ZERO
var elapsed_time: float = 0.0


func setup():
	hit_count = 0
	elapsed_time = 0.0


func _physics_process(delta):
	if elapsed_time >= lifetime:
		remove()

	position += (direction * speed * delta)

	elapsed_time += delta
