class_name ItemStaticState
extends StateMachine


func enter_state(node):
	(node as RigidBody2D).set_process(false)
	
