class_name Player
extends Area2D

@export var rotation_speed: int = 20
@export var hit_invincibility_time: float = 0.2


var character: PlayerCharacterSheet = null


func _ready():
	Events.character_selected.connect(_on_character_selected)
	Events.experience_received.connect(_on_experience_received)
	Events.item_picked_up.connect(_on_item_picked_up)
	body_entered.connect(_handle_collision)


func _process(delta):
	_process_movement(delta)
	
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


func _process_movement(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.length() == 0:
		$AnimatedSprite2D.play("default")

	# normalize the direction vector so you can't move faster in the diagonal
	# than you can in just the horizontal/vertical
	var move_speed = character.calc_move_speed(State.standard_move_speed)
	
	position += direction.normalized() * move_speed * delta


func _handle_collision(collider: Node2D):
	if character.is_dead:
		return
	
	if collider is Item:
		collider.on_pickup()
	if collider is Enemy:
		take_damage(collider.character.stats.attack.total_value())


func take_damage(attack_damage: int):
	if character.is_damagable:
		character.is_damagable = false
		_flash(Color.RED)
		character.take_damage(attack_damage)		
		await get_tree().create_timer(hit_invincibility_time).timeout
		character.is_damagable = true
	
	if character.is_dead:
		print_debug("character dead, call game_over")
		GameManager.game_over()
		
		
func _on_character_selected(character_sheet: PlayerCharacterSheet):
	character = character_sheet
	

func _on_experience_received():
	_flash()


func _on_item_picked_up(item):
	call_deferred("add_child", item)


func _on_field_body_entered(body):
	if body != self and body is Item:
		(body as Item).seek_player()
		

func _flash(color: Color = Color.WHITE):
	ShaderEffects.flash($AnimatedSprite2D.material, true, color)
	await get_tree().create_timer(0.1).timeout
	ShaderEffects.flash($AnimatedSprite2D.material, false, color)
	

func _on_claw_body_entered(body: Node2D):
	if body.is_in_group("enemy"):
		# calc damage, do damage, is enemy dead, what do they drop
		body.take_damage(character.stats.attack.total_value())
		
