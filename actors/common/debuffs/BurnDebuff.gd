class_name BurnDebuff
extends DOTDebuff


func set_is_active(value: bool) -> void:
	is_active = value
	damage_interval_ticks = 0.0
	elapsed_time = 0.0
	visible = is_active
