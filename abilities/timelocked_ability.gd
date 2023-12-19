class_name TimelockedAbility
extends Node

@export var lock_time: float = 1.0  ## time to lock the ability in seconds

var time_since_last_use: float


func _ready():
	setup()
	
	
func setup():
	time_since_last_use = 9999999


func _process(delta):
	time_since_last_use += delta


func is_usable():
	return time_since_last_use > lock_time


func _on_execute(_extra_vars = {}):
	time_since_last_use = 0

