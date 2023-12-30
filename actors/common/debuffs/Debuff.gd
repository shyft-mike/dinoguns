class_name Debuff
extends Node2D

signal debuff_removed

var elapsed_time: float = 0.0
var lifetime: float = 3.0
var is_active: bool = false:
	set = set_is_active,
	get = get_is_active


func _process(delta) -> void:
	if elapsed_time >= lifetime:
		set_is_active(false)
		debuff_removed.emit()
		return

	elapsed_time += delta


func set_is_active(value: bool) -> void:
	pass


func get_is_active() -> bool:
	return is_active
