class_name Item
extends RigidBody2D

enum ItemState { STATIC, LAUNCHED, SEEKING }

@export var state := ItemState.STATIC : set = set_state
@export var friction: float = 1.2
@export var stop_threshold: float = 5.0

func _ready():
	gravity_scale = 0
	set_physics_process(false)


func on_pickup():
	assert(false, "on_pickup method of class Item not defined")


func set_state(value: ItemState):
	state = value
	
	if state == ItemState.STATIC:
		set_physics_process(false)
	else:
		set_physics_process(true)


func seek_player():
	state = ItemState.SEEKING


func remove():
	state = ItemState.STATIC
	if is_inside_tree():
		get_parent().remove_child(self)
		
	
func launch(direction: Vector2 = Vector2.ZERO):
	state = ItemState.LAUNCHED
	
	if direction.length() == 0:
		direction = Vector2(randi_range(-100, 100),randi_range(-100, 100))
	
	linear_velocity = direction
	angular_velocity = direction.angle() / friction
	
	
func _physics_process(delta):
	match state:
		ItemState.SEEKING:
			rotation = global_position.angle_to(State.player.global_position) * delta * 40
			global_position = global_position.move_toward(State.player.global_position, delta * 100)
			
		ItemState.LAUNCHED:
			linear_velocity -= (friction * linear_velocity.normalized())
			if linear_velocity.length() < stop_threshold:
				linear_velocity = Vector2.ZERO
				angular_velocity = 0
				state = ItemState.STATIC
	
#	velocity.y += gravity * delta
#	velocity.x -= friction * delta
#
#	position += velocity * delta
	
#	if position.cross(direction_of_ground) < 0:
#		position.y = direction_of_ground.y * position.x
#		if velocity.length() < stop_threshold:
#			velocity = Vector2.ZERO
#			set_physics_process(false)
#		else:
#			velocity.y = -abs(velocity.y) * 0.5

