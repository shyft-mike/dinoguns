extends CharacterBody2D

var player 

func _ready():
	player = get_tree().get_first_node_in_group("players")
	position = player.position + Vector2(1000, 0).rotated(randf_range(0, 2*PI))
	

func _physics_process(delta):
#	velocity = (player.position - position).normalized() * 100 / delta
	global_position = global_position.move_toward(player.global_position, delta * 25)

	move_and_slide()
