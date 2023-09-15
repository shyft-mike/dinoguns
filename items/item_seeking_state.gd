class_name ItemSeekingState
extends StateMachine

var seek_tween: Tween
var initial_seek_speed: float = 100.0


func enter_state(node):
	(node as RigidBody2D).set_process(true)
	
	
func exit_state(node):
	initial_seek_speed = 100.0

	
func process_physics(node, delta):
	if not seek_tween or not seek_tween.is_running():
		start_seek_tween(node)


func start_seek_tween(node):
	if seek_tween:
		seek_tween.kill()
		
	var direction_to_player = node.global_position.direction_to(State.player.global_position)
	print_debug(direction_to_player)
	direction_to_player = direction_to_player.normalized() * initial_seek_speed
		
	seek_tween = node.get_tree().create_tween()
	seek_tween.tween_property(node, "position", direction_to_player, 0.3)
	seek_tween.play()
	initial_seek_speed *= 1.01
