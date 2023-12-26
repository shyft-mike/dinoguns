extends Level

const RAPTOR_TEMPLATE = preload("res://actors/players/raptor/RaptorPlayer.tscn")


func _ready():
	var new_player = RAPTOR_TEMPLATE.instantiate()

	Events.character_selected.emit(new_player)

	SpawnManager.spawn(Vector2(100, 100))
