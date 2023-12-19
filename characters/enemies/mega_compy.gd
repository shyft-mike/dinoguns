extends Enemy

@onready var fireball_timer: Timer = $FireballTimer
@onready var fireball_count: int = 3

@export var attack_rate := 1.0
@export var target_distance := 800.0


func _ready():
	setup()
	
	fireball_timer.wait_time = attack_rate
	fireball_timer.timeout.connect(_on_fireball_timer_timeout)


func setup():
	super.setup()
	if not fireball_timer.is_stopped():
		fireball_timer.stop()
	
	fireball_timer.start()
	
	
func _on_fireball_timer_timeout():
	var distance_to_player = global_position.distance_to(State.player.global_position)
	
	if distance_to_player < target_distance:
		var previous_state = current_state
		current_state = EnemyState.STOPPED
		animated_sprite.play("shoot")
		var direction_to_player = main_ability_marker.global_position.direction_to(State.player.global_position)		
		
		var fireballs_shot = 0
		
		while fireballs_shot < fireball_count and not is_dead:
			abilities.execute(
				Ability.AbilityType.FIREBALL, 
				{ "spawn_location": main_ability_marker.global_position, "direction": direction_to_player, "speed": 300.0 })
			fireballs_shot += 1
			await get_tree().create_timer(0.2).timeout

		if not is_dead:
			current_state = previous_state
