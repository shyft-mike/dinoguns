extends ProgressBar


func _ready():
	Events.experience_received.connect(_update)
	_update()
	

func _update(_experience = null):
	max_value = State.selected_character.to_next_level
	value = State.selected_character.experience
