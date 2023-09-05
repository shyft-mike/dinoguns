extends CharacterBody2D
class_name Player

@export var rotation_speed: int = 20

@onready var damage_popup := preload("res://interface/damage_popup.tscn")

var _character: PlayerCharacter = null


func _ready():
	Events.character_selected.connect(_on_character_selected)
	Events.experience_received.connect(_on_experience_received)


func _process_movement(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
	if direction.length() == 0:
		$AnimatedSprite2D.play("default")
		
	# normalize the direction vector so you can't move faster in the diagonal
	# than you can in just the horizontal/vertical
	var move_speed = _character.calc_move_speed(State.standard_move_speed)
	var collision = move_and_collide(direction.normalized() * move_speed * delta)
	
	if collision:
		_handle_collision(collision)


func _handle_collision(collision: KinematicCollision2D):
	var collider = collision.get_collider()
	if collider is Item:
		collider.on_pickup()


func _physics_process(delta):
	_process_movement(delta)


func _process(delta):
	var mouse_position = get_global_mouse_position()
	var angle = rad_to_deg(global_position.angle_to_point(mouse_position))
	
	$TargetPoint.position = (mouse_position - global_position).normalized() * 50
	
	# quadrants
	if angle >= -22.5 and angle <= 22.5:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.play("walk_right")
	if angle >= 22.5 and angle <= 67.5:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.play("walk_diag_down")
	if angle >= 67.5 and angle <= 112.5:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.play("walk_down")
	if angle >= 112.5 and angle <= 157.5:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.play("walk_diag_down")		
	if angle >= 157.5 or angle <= -157.5:
		$AnimatedSprite2D.flip_h = false		
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.play("walk_right")
	if angle >= -157.5 and angle <= -112.5:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.play("walk_diag_up")
	if angle >= -112.5 and angle <= -67.5:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.play("walk_down")
	if angle >= -67.5 and angle <= -22.5:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.play("walk_diag_up")

		
func _on_character_selected(character: PlayerCharacter):
	_character = character
	

func _on_experience_received(value: int):
	_flash()
	

func _on_field_body_entered(body):
	if body != self and body is Item:
		(body as Item).player_to_move_to = self
		

func _flash():
	ShaderEffects.flash($AnimatedSprite2D.material, true)
	await get_tree().create_timer(0.1).timeout
	ShaderEffects.flash($AnimatedSprite2D.material, false)
	

func _on_claw_body_entered(body: Node2D):
	if body.is_in_group("enemy"):
		# calc damage, do damage, is enemy dead, what do they drop
		body.take_damage(10)
		var damage_popup_instance = damage_popup.instantiate() as DamagePopup
		get_parent().add_child(damage_popup_instance)
		damage_popup_instance.execute("10", body.global_position, 0, 0)
		
