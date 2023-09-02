extends CharacterBody2D


var character: EnemyCharacter
var player 

func _ready():
	player = get_tree().get_first_node_in_group("players")
	position = player.position + Vector2(1000, 0).rotated(randf_range(0, 2*PI))
	

func _physics_process(delta):
#	velocity = (player.position - position).normalized() * 100 / delta
	global_position = global_position.move_toward(player.global_position, delta * character.stats.calc_move_speed(State.standard_move_speed))

	var collided = move_and_slide()
	
	if collided:
		var collision_count = get_slide_collision_count()
		for i in collision_count:
			var collision = get_slide_collision(i)
			var collider = collision.get_collider() as Node2D

			if collider.name == "Player":
				character.drops[0].global_position = global_position
				get_parent().add_child(character.drops[0])
				queue_free()
