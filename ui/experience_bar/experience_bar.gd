extends TextureProgressBar

@export var value_tween_time: float = 0.4

var value_tween: Tween


func _ready():
	Events.experience_received.connect(_update)
	Events.player_leveled_up.connect(_update)


func _update(_experience = null):
	if value_tween:
		value_tween.kill()

	value_tween = get_tree().create_tween()
	value_tween.tween_property(self, "value", float(State.player.stat_manager.experience), value_tween_time)

	max_value = State.player.stat_manager.to_next_level
