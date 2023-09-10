extends Enemy

@export var attack_rate := 1.0
@export var target_distance := 800.0
@export var fireball_template := preload("res://items/projectiles/fireball.tscn")


func _ready():
	super._ready()
	
	$FireballTimer.wait_time = 1.2 / attack_rate
	$FireballTimer.connect("timeout", _on_fireball_timer_timeout)
	
	
func _on_fireball_timer_timeout():
	var distance_to_player = global_position.distance_to(State.player.global_position)
	
	if distance_to_player < target_distance:
		var direction_to_player = $FireballStartMarker2D.global_position.direction_to(State.player.global_position)		
		var fireball = fireball_template.instantiate() as Fireball
		fireball.lifetime = 3
		fireball.global_position = $FireballStartMarker2D.global_position
		get_parent().add_child(fireball)
		
		fireball.shoot(direction_to_player, 150.0)
		
