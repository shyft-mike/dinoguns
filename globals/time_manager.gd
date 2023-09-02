extends Node

var _event_timer: Timer
var _spawn_timer: Timer


func _ready():
	_configure_timers()


func reset():
	_event_timer.queue_free()
	_spawn_timer.queue_free()
	_configure_timers()
	return self
	
	
func start():
	_event_timer.start()
	_spawn_timer.start()
	return self
	

func _configure_timers():
	_event_timer = Timer.new()
	_event_timer.wait_time = 60
	_event_timer.timeout.connect(_on_event_timer_timeout)
	add_child(_event_timer)
	
	_spawn_timer = Timer.new()
	_spawn_timer.wait_time = 1
	_spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(_spawn_timer)
	

func _on_event_timer_timeout():
	print_debug("event!")
	
	
func _on_spawn_timer_timeout():
	var enemy = load("res://characters/enemies/enemy.tscn").instantiate()
	enemy.character = CharacterFactory.generate_character(CharacterFactory.CharacterType.COMPY)
	get_tree().get_first_node_in_group("spawner").add_child(enemy)
