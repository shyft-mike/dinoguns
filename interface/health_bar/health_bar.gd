extends ProgressBar


func _ready():
	Events.player_health_changed.connect(_update_health)
	_update_health()
	

# Health Bar! Maybe need to separate in the future so that max value only changes when max hp changes.
# Such as a power up or mutation. 
func _update_health():
	max_value = State.selected_character.stats.health.total_value()
	value = State.selected_character.stats.current_health
