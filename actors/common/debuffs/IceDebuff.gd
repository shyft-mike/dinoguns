class_name IceDebuff
extends Debuff


func set_is_active(value: bool) -> void:
	is_active = value
	elapsed_time = 0.0
	visible = is_active
