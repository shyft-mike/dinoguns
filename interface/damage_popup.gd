extends Node2D
class_name DamagePopup


func remove() -> void:
	$AnimationPlayer.stop()
	if is_inside_tree():
		get_parent().remove_child(self)


func execute(value: String, start_position: Vector2, height: float, spread: float) -> void:
	$LabelContainer/Label.text = value
	$AnimationPlayer.play("swell")
	
	var tween = get_tree().create_tween()
	var end_position = Vector2(randf_range(-spread, spread), -height) + start_position
	var tween_length = $AnimationPlayer.get_animation("swell").length
	
	tween.tween_property($LabelContainer, "position", end_position, tween_length).from(start_position)
