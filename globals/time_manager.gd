extends Node

var _event_timer: Timer
var _spawn_timer: Timer
var _regen_timer: Timer


func _ready():
	_create_timers()


func reset():
	_event_timer.queue_free()
	_spawn_timer.queue_free()
	_regen_timer.queue_free()
	_create_timers()
	
	
func start():
	_event_timer.start()
	_spawn_timer.start()
	_regen_timer.start()
	

func _create_timers():
	_event_timer = _create_timer(60, _on_event_timer_timeout)
	_spawn_timer = _create_timer(1, _on_spawn_timer_timeout)
	_regen_timer = _create_timer(5, _on_regen_timer_timeout)
	

func _create_timer(wait_time: float, timeout_event: Callable) -> Timer:
	var timer = Timer.new()
	timer.wait_time = wait_time
	timer.timeout.connect(timeout_event)
	add_child(timer)
	return timer


func _on_event_timer_timeout():
	print_debug("event!")
	
	
func _on_spawn_timer_timeout():
	var enemy = load("res://characters/enemies/enemy.tscn").instantiate()
	enemy.character = CharacterFactory.generate_character(CharacterFactory.CharacterType.COMPY)
	get_tree().get_first_node_in_group("spawner").add_child(enemy)


func _on_regen_timer_timeout():
	State.selected_character.regen()
