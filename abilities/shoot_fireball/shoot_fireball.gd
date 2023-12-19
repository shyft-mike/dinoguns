class_name ShootFireball
extends Ability


func execute(options: Dictionary):
	if not is_inside_tree():
		print_debug("tried to execute while outside the tree: ", self)
		return
		
	var spawn_location = options.spawn_location
	var direction = options.direction
	var speed = 25.0
	var lifetime = 3.0
	
	if options.has("speed"):
		speed = options.speed
	if options.has("lifetime"):
		lifetime = options.lifetime
	
	var fireball = ProjectileFactory.generate(Projectile.ProjectileType.FIREBALL)
	fireball.global_position = spawn_location
	fireball.direction = direction
	fireball.lifetime = lifetime
	fireball.speed = speed
	get_node("/root").add_child(fireball)
