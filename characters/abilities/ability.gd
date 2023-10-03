class_name Ability
extends Node

signal hit (body: Node2D)

@export var ACTIVE_TIME: float = 1.0
@export var WEAPON: NodePath

var _activated: bool = false


func _ready():	
	setup()
	
	
func setup():
	pass


func activate(extra_vars = {}):
	_activated = true
	get_tree().create_timer(ACTIVE_TIME).timeout.connect(on_attack_timer_timeout)


func can_attack() -> bool:
	return !_activated


func on_attack_timer_timeout():
	_activated = false
	
