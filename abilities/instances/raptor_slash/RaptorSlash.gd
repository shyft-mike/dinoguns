class_name RaptorSlash
extends Ability

@export var claw_template: PackedScene = preload("res://abilities/raptor_slash/RaptorClaw.tscn")


func _internal_activate(user: Actor, spawn_marker: Marker2D = null) -> void:
	var claw = claw_template.instantiate() as Damager
	claw.user = user
	claw.position = spawn_marker.position

	user._body.add_child(claw)

	var claw_animation_player = claw.get_node("AnimationPlayer") as AnimationPlayer
	claw_animation_player.play("attack")
	claw_animation_player.animation_finished.connect(_on_animation_finished.bind(claw))


func _on_animation_finished(_anim, claw):
	claw.remove()
