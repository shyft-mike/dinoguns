extends Node2D

signal fire

@export var projectile_scene: PackedScene
var _projectile

func _ready():
	_projectile = projectile_scene.instantiate()
	add_child(_projectile)
	

func _draw():
	draw_circle(Vector2(0, 0), 4, Color.RED)


func _on_timer_timeout():
	_projectile.fire()
