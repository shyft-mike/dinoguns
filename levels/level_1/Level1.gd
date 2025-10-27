extends Level

@onready var spawn_timer: Timer = $SpawnTimer
#@onready var dialog_balloon: Balloon = $UILayer/Interface/BottomBar/VBox/DialogBalloon

var minutes_elapsed: float

func _init():
	minutes_elapsed = 0.0


func _ready():
	super._ready()

	var squad = ResourceLoader.load("res://actors/enemies/compy_squad/CompySquad.tscn").instantiate()
	squad.global_position = SpawnManager._get_random_spawn_location()
	SceneManager.current_scene.spawns_container.add_child(squad)

	var uzi = ResourceLoader.load("res://items/pickups/weapons/uzi/UziItem.tscn").instantiate()
	SceneManager.current_scene.items_container.add_child(uzi)
	uzi.global_position = State.player.global_position + Vector2(10, 10)

	#spawn_timer.timeout.connect(_on_spawn_timer_timeout)

	#dialog_balloon.start(ResourceLoader.load("res://characters/player/raptor/raptor.dialogue"), "start")


func _on_spawn_timer_timeout():
	minutes_elapsed += 1 / 60.0

	var spawn_events = spawn_flow.get_spawn_events(minutes_elapsed)

	# handle spawning all the spawn events
	for event in spawn_events:
		for i in event.count:
			SpawnManager.spawn()
