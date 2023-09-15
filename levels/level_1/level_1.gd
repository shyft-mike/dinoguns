extends Level

@onready var spawn_timer: Timer = $SpawnTimer

var minutes_elapsed: float


func _init():
	minutes_elapsed = 0.0
	
		
func _ready():
	super._ready()
	
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

	
func _on_spawn_timer_timeout():
	minutes_elapsed += 1 / 60.0
	
	var spawn_events = spawn_flow.get_spawn_events(minutes_elapsed)
	
	# handle spawning all the spawn events
	for event in spawn_events:
		for i in event.count:
			SpawnManager.spawn(event.spawn)
