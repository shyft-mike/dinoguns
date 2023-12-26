class_name HurtBox
extends Area2D


signal hurt_box_collided (area)


func _on_area_entered(area: Area2D):
	hurt_box_collided.emit(area)
