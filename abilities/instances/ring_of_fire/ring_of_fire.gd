extends Node2D


var _rotation_speed := 1.0


func _process(delta):	
	$Balls.rotation += _rotation_speed * delta
