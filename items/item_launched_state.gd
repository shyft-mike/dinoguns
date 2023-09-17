class_name ItemLaunchedState
extends StateMachine


func enter_state(node):
	(node as RigidBody2D).set_process(true)
	
	
func exit_state(node):
	node.linear_velocity = Vector2.ZERO
	node.angular_velocity = 0
	
	
func process_physics(node, delta):
#	print_debug("launched item pos: ", node.position)
#	print_debug("launched item gpos: ", node.global_position)
#	print_debug("launched item ", node.get_instance_id(), " linear v: ", node.linear_velocity)
	node.linear_velocity -= (node.friction * node.linear_velocity.normalized())
	if node.linear_velocity.length() < node.stop_threshold:
		node.set_state(Item.ItemState.STATIC)
