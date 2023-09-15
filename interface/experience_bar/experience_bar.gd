extends ProgressBar


func _ready():
	Events.experience_received.connect(_update)
	Events.player_leveled_up.connect(_update)
	

func _update(_experience = null):
	max_value = State.player.to_next_level
	value = State.player.experience
