class_name Move
extends Ability


func execute(options: Dictionary):
	var direction: Vector2 = options.direction
	var delta: float = options.delta
	
	if not direction.is_normalized(): 
		direction = direction.normalized()
	
	var new_velocity = direction * CharacterService.calc_move_speed(user)
	
	user.previous_position = user.position
	
	# This is probably going to be a problem eventually
	if "move_and_slide" in user:
		user.velocity = new_velocity
		user.move_and_slide()
	else:
		user.position += new_velocity * delta
		
	user.linear_velocity = (user.position - user.previous_position) / delta
	
