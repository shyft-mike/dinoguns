extends Enemy

@export var attack_rate := 1.0
@export var target_distance := 800.0
@export var fireball_template := preload("res://items/projectiles/fireball.tscn")


func _ready():
	super.setup()
	
	$Enemy/FireballTimer.wait_time = 1.2 / attack_rate
	$Enemy/FireballTimer.connect("timeout", _on_fireball_timer_timeout)
	
	
func _on_fireball_timer_timeout():
	var distance_to_player = global_position.distance_to(State.player.global_position)
	
	if distance_to_player < target_distance:
		var direction_to_player = $Enemy/FireballStartMarker2D.global_position.direction_to(State.player.global_position)		
		var fireball = fireball_template.instantiate() as Fireball
		fireball.global_position = $Enemy/FireballStartMarker2D.global_position
		fireball.direction = direction_to_player
		fireball.lifetime = 3.0
		get_parent().add_child(fireball)
			
