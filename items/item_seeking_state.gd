class_name ItemSeekingState
extends StateMachine

var seek_tween: Tween
var initial_seek_speed: float = 100.0


func enter_state(node):
	(node as RigidBody2D).set_process(true)
	
	
func exit_state(node):
	initial_seek_speed = 100.0
	
	if seek_tween:
		seek_tween.kill()

	
func process_physics(node, delta):
	if not seek_tween or not seek_tween.is_running():
		start_seek_tween(node, delta)


func start_seek_tween(node, delta):
	if seek_tween:
		seek_tween.kill()
		
	var direction_to_player = node.global_position.direction_to(State.player.global_position)
	var speed = direction_to_player.normalized() * initial_seek_speed
	
	var seek_position = node.position + speed
	
	seek_tween = node.get_tree().create_tween()
	seek_tween.tween_property(node, "position", seek_position, 0.1)
	seek_tween.play()
	initial_seek_speed *= 1.01
