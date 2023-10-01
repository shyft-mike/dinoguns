extends TextureProgressBar

@export var value_tween_time: float = 0.2

var value_tween: Tween


func _ready():
	Events.player_health_changed.connect(_update_health)


# Health Bar! Maybe need to separate in the future so that max value only changes when max hp changes.
# Such as a power up or mutation. 
func _update_health(_value):
	if value_tween:
		value_tween.kill()
		
	value_tween = get_tree().create_tween()
	value_tween.tween_property(self, "value", State.player.current_health, value_tween_time)
	
	max_value = State.player.health.total_value()
