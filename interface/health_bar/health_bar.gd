extends TextureProgressBar


func _ready():
	Events.player_health_changed.connect(_update_health)


# Health Bar! Maybe need to separate in the future so that max value only changes when max hp changes.
# Such as a power up or mutation. 
func _update_health(_value):
	max_value = State.player.health.total_value()
	value = State.player.current_health
