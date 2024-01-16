class_name Talent
extends Resource

@export var icon: Texture2D
@export var tree_type: Upgrade.PowerType
@export var name: String
@export var is_disabled: bool = false
@export var level: int = 0
@export var max_level: int = 1


func set_disabled(value: bool) -> void:
	is_disabled = value
	if is_disabled:
		level = 0


func load_from_dict(data: Dictionary) -> void:
	name = data.name
	level = data.level


func to_dict() -> Dictionary:
	return {
		"name": name,
		"level": level
	}
