extends Area2D
class_name Fireball

@export var lifetime := 0

var _initial_speed: float = 25.0
var _direction: Vector2
var _speed: float

func _ready():
	if lifetime > 0:
		await get_tree().create_timer(lifetime).timeout
		queue_free()
		
	set_physics_process(false)


func _physics_process(delta):
	position += _direction.normalized() * _speed * delta
	

func shoot(direction: Vector2, speed: float):
	_direction = direction
	_speed = _initial_speed
	
	set_physics_process(true)
	
	await get_tree().create_timer(0.2).timeout
	
	# maximum speed!
	_speed = speed
