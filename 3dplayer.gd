extends CharacterBody3D

@export var speed := 4.0
@export var gravity := 30.0

var velocity_y := 0.0
var is_facing_right = false
var is_rotated = false
var is_attacking: bool: set = _set_is_attacking


func _ready():
	is_attacking = false
	$Claw/AnimationPlayer.animation_finished.connect(func(name): is_attacking = not name == "slash")

func _physics_process(delta):
	var direction_ground := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	if direction_ground.x != 0:
		is_facing_right = direction_ground.x > 0
	
	direction_ground = direction_ground.rotated(deg_to_rad(45))
	
	$RotationOffset/Sprite3D.flip_h = is_facing_right
	
	if is_facing_right:
		if not is_rotated:
			$CollisionShape3D.rotate_x(deg_to_rad(180))
			is_rotated = true
	elif is_rotated:
		$CollisionShape3D.rotate_x(deg_to_rad(-180))
		is_rotated = false
	
	if not is_on_floor():
		velocity_y -= gravity * delta
	
	velocity = Vector3(
		direction_ground.x * speed,
		velocity_y,
		direction_ground.y * speed
	)
	
	move_and_slide()

	if is_on_floor() or is_on_ceiling():
		velocity_y = 0.0


func _set_is_attacking(value):
	is_attacking = value
	
	$Claw.visible = is_attacking
	

func _unhandled_input(event):
	if not is_attacking and event.is_action_pressed("main_attack"):
		is_attacking = true
		$Claw/AnimationPlayer.play("slash")
