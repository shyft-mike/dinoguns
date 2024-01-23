class_name Ability
extends Node2D

@export var interval: float = 1.0
@export var can_rotate: bool = false

# Modifiers that affect the ability itself
var attached_modifiers: Array[Modifier] = []

# Modifiers that affect the damager(s) generated by the ability.
# Behaves like a singleton, so don't use if your modifier requires state.
var attached_damager_modifiers: Array[Modifier] = []

# Like the damager modifiers, but should be called to generate a stateful
# modifier.
var attached_damager_callables: Array[Callable] = []

var elapsed: float = 0.0
var activated: bool = false


func activate(_user: Actor, _spawn_marker: Marker2D = null) -> void:
	if activated:
		return
	else:
		on_activated()
		_internal_activate(_user, _spawn_marker)
		on_deactivated()


func _internal_activate(_user: Actor, _spawn_marker: Marker2D = null) -> void:
	pass


func on_activated() -> void:
	activated = true


func on_deactivated() -> void:
	elapsed = 0.0
	activated = false
