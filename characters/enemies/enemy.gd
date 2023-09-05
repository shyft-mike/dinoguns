extends CharacterBody2D

enum EnemyState {PERSUING,RETREATING}

var current_state: EnemyState = EnemyState.PERSUING
var last_sighting: Vector2
var character: EnemyCharacter
var player 


func _ready():
	$AnimatedSprite2D.play($AnimatedSprite2D.animation)
	player = get_tree().get_first_node_in_group("players")
	position = player.position + Vector2(1000, 0).rotated(randf_range(0, 2*PI))
	

func _physics_process(delta):
	var direction_to_player = global_position.direction_to(player.global_position)
	var distance_to_player = global_position.distance_to(player.global_position)
	
	match current_state:
		EnemyState.PERSUING:
			if distance_to_player > 50:
				velocity = direction_to_player * character.calc_move_speed(State.standard_move_speed)
			if distance_to_player <= 50:
				current_state = EnemyState.RETREATING
				last_sighting = player.global_position
				velocity = -direction_to_player * character.calc_move_speed(State.standard_move_speed) * 1.1
		
		EnemyState.RETREATING:
			velocity = -global_position.direction_to(last_sighting) * character.calc_move_speed(State.standard_move_speed) * 1.1
			if global_position.distance_to(last_sighting) > 300:
				current_state = EnemyState.PERSUING
		
	move_and_slide()


func take_damage(attack_damage: int):
	_flash()
	character.take_damage(attack_damage)
	
	if character.stats.current_health <= 0:
		character.drops[0].global_position = global_position
		get_parent().call_deferred("add_child", character.drops[0])
		queue_free()


func _flash():
	($AnimatedSprite2D.material as ShaderMaterial).set_shader_parameter("active", true)
	await get_tree().create_timer(0.1).timeout
	($AnimatedSprite2D.material as ShaderMaterial).set_shader_parameter("active", false)
