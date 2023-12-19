class_name RaptorSlash
extends TimelockedAbility

@export var claw_template: PackedScene = preload("res://abilities/raptor_slash/raptor_claw.tscn")


func execute(spawn_location: Vector2, flip: bool):
	if not is_usable():
		return
	
	_on_execute()
		
	var claw = claw_template.instantiate() as Area2D
	
	if flip:
		claw.scale *= Vector2(-1,1)
	
	claw.global_position = spawn_location
	get_parent().add_child(claw)
	var claw_animation_player = claw.get_node("AnimationPlayer") as AnimationPlayer
	claw_animation_player.play("attack")
	claw_animation_player.animation_finished.connect(
		func(_anim):
			if is_inside_tree():
				get_parent().remove_child(claw)
	)
	
