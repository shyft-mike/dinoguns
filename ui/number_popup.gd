class_name NumberPopup
extends Node2D

@onready var label_container: Node2D = $LabelContainer
@onready var label: Label = $LabelContainer/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func remove() -> void:
	animation_player.stop()
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)


func _execute(value: String, start_position: Vector2, height: float, spread: float) -> void:
	label.text = value
	animation_player.play("swell")

	var tween = get_tree().create_tween()
	var end_position = Vector2(randf_range(-spread, spread), -height) + start_position
	var tween_length = animation_player.get_animation("swell").length

	tween.tween_property(label_container, "position", end_position, tween_length).from(start_position)


func damage(value: String, start_position: Vector2, height: float, spread: float) -> void:
	label.modulate = Color.RED
	_execute(value, start_position, height, spread)


func health(value: String, start_position: Vector2, height: float, spread: float) -> void:
	label.modulate = Color.LAWN_GREEN
	_execute(value, start_position, height, spread)

