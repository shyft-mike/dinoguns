extends Node

var _event_timer: Timer
var _spawn_timer: Timer
var _regen_timer: Timer
var _clock_timer: Timer

func _ready():
	_create_timers()


func reset():
	_event_timer.queue_free()
	_spawn_timer.queue_free()
	_regen_timer.queue_free()
	_clock_timer.queue_free()
	_create_timers()
	
	
func start():
	_event_timer.start()
	_spawn_timer.start()
	_regen_timer.start()
	_clock_timer.start()
	

func _create_timers():
	_event_timer = _create_timer(5, _on_event_timer_timeout)
	_spawn_timer = _create_timer(1, _on_spawn_timer_timeout)
	_regen_timer = _create_timer(5, _on_regen_timer_timeout)
	_clock_timer = _create_timer(0.1, _on_clock_timer_timeout)

func _create_timer(wait_time: float, timeout_event: Callable) -> Timer:
	var timer = Timer.new()
	timer.wait_time = wait_time
	timer.timeout.connect(timeout_event)
	add_child(timer)
	return timer


func _on_event_timer_timeout():
	SpawnManager.spawn(CharacterFactory.CharacterType.MEGA_COMPY)
	
	
func _on_spawn_timer_timeout():
	SpawnManager.spawn(CharacterFactory.CharacterType.COMPY)


func _on_regen_timer_timeout():
	State.player.character.regen()
	
# TODO: handle this elsewhere
#var _ticks_per_day = 60
#var _ticks = 0
#enum TimePeriod {MORNING,DAY,EVENING,NIGHT}
#const MORNING_COLOR = Color8(227, 153, 85)
#const DAY_COLOR = Color8(223, 205, 161)
#const EVENING_COLOR = Color8(248, 148, 100)
#const NIGHT_COLOR = Color8(88, 104, 94)
#
func _on_clock_timer_timeout():
	pass
#	_ticks += 1
#	var new_color
#	if _ticks <= 60:
#		new_color = NIGHT_COLOR.lerp(MORNING_COLOR, (_ticks - 45) / 15.0)
#	if _ticks <= 45:
#		new_color = EVENING_COLOR.lerp(NIGHT_COLOR, (_ticks - 30) / 15.0)
#	if _ticks <= 30:
#		new_color = DAY_COLOR.lerp(EVENING_COLOR, (_ticks - 15) / 15.0)
#	if _ticks <= 15:
#		new_color = MORNING_COLOR.lerp(DAY_COLOR, _ticks / 15.0)
#
#	print_debug("Clock Timer: ", _ticks)
#	print_debug("New Color: ", new_color)
#
#	if _ticks >= 60:
#		_ticks = 0
#
#	Events.time_of_day_changed.emit(new_color)
