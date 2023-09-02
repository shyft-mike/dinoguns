extends CharacterBody2D


var character: EnemyCharacter
var player 

func _ready():
	$AnimatedSprite2D.play($AnimatedSprite2D.animation)
	player = get_tree().get_first_node_in_group("players")
	position = player.position + Vector2(1000, 0).rotated(randf_range(0, 2*PI))
	

func _physics_process(delta):
#	velocity = (player.position - position).normalized() * 100 / delta
	global_position = global_position.move_toward(player.global_position, delta * character.calc_move_speed(State.standard_move_speed))

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
