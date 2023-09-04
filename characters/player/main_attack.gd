extends Node2D

var target_point: Node2D


func _ready():
	target_point = get_parent().find_child("TargetPoint") as Node2D
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)


func _unhandled_input(event):
	"""TODO: This is too tightly coupled"""
	if event.is_action_pressed("attack"):
		visible = true
		var angle = position.angle_to_point(target_point.position)
#		print_debug("Attack")
#		print_debug("target_point.position: ", target_point.position)
#		print_debug("get_parent().position: ", get_parent().position)
#		print_debug("position: ", position)
#		print_debug("global_position: ", global_position)
#		print_debug("angle_to_point: ", rad_to_deg(angle))
		position = target_point.position
		rotation = angle + (PI)
		$AnimationPlayer.play("slash")


func _on_animation_finished(animation_name):
	if animation_name == "slash":
		visible = false
