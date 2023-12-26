class_name HitBox
extends Area2D

signal hit_box_collided (area)


var damage: DamageService.Damage


func _on_area_entered(area: Area2D):
	hit_box_collided.emit(area)
