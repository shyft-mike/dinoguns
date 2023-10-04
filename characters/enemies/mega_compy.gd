extends Enemy

@onready var fireball_timer: Timer = $FireballTimer
@onready var fireball_spawn_location: Marker2D = $FireballStartMarker2D

@export var attack_rate := 1.0
@export var target_distance := 800.0

# Abilities
var fireball: Fireball


func _ready():
	super.setup()
	
	fireball = load_ability("fireball")
	
	fireball_timer.wait_time = 1.2 / attack_rate
	fireball_timer.timeout.connect(_on_fireball_timer_timeout)
	
	
func _on_fireball_timer_timeout():
	var distance_to_player = global_position.distance_to(State.player.global_position)
	
	if distance_to_player < target_distance:
		var direction_to_player = fireball_spawn_location.global_position.direction_to(State.player.global_position)		
		
		fireball.execute(fireball_spawn_location.global_position, direction_to_player, 300.0)
