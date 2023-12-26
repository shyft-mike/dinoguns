class_name ItemSeekingState
extends StateMachine

var seek_tween: Tween
var initial_seek_speed: float = 50.0
var seek_speed: float


func enter_state(node):
	(node as RigidBody2D).set_process(true)
	seek_speed = initial_seek_speed


func exit_state(node):
	if seek_tween:
		seek_tween.kill()


func process_physics(node, delta):
	if not seek_tween or not seek_tween.is_running():
		start_seek_tween(node, delta)


func start_seek_tween(node, delta):
	if seek_tween:
		seek_tween.kill()

	var player_position = State.player.global_position
	#player_position.y += 10
	var direction_to_player = node.global_position.direction_to(player_position)
	var speed = direction_to_player.normalized() * initial_seek_speed

	var seek_position = node.global_position + speed

	if has_passed_target(seek_position, player_position, direction_to_player):
		node.pickup()
		return

	seek_tween = node.get_tree().create_tween()
	seek_tween.tween_property(node, "global_position", seek_position, 0.1)
	seek_speed *= 1.01


func has_passed_target(current_position, target_position, direction):
	var has_passed_x = false
	var has_passed_y = false

	if direction.x > 0:
		has_passed_x = current_position.x > target_position.x
	elif direction.x < 0:
		has_passed_x = current_position.x < target_position.x

	if direction.y > 0:
		has_passed_y = current_position.y > target_position.y
	elif direction.y < 0:
		has_passed_y = current_position.y < target_position.y

	return has_passed_x and has_passed_y

