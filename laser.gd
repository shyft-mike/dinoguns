extends RayCast2D

var is_casting := false:
	set = set_is_casting
	

func _ready():
	$Line2D.points[1] = Vector2.ZERO

	
func _physics_process(delta):
	var cast_point := target_position
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		
	$Line2D.points[1] = cast_point


func set_is_casting(value):
	is_casting = value
	
	if is_casting:
		appear()
	else:
		disappear()
	
	set_physics_process(is_casting)


func fire():
	if not is_casting:
		is_casting = true
		
		await get_tree().create_timer(0.5).timeout
		
		is_casting = false
	
	# how to handle "skipped" firing?	
		

func appear():
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D, "width", 10.0, 0.2)
	tween.play()
	

func disappear():
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D, "width", 0.0, 0.1)
	tween.play()
