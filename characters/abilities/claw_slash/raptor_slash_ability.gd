class_name RaptorSlashAbility
extends Ability


func activate(extra_vars = {}):
	if not can_attack():
		return
	
	super.activate(extra_vars)
	collision.disabled = false
	show()
	animation_player.play("attack")
	
	if not animation_player.animation_finished.is_connected(_on_animation_finished):
		animation_player.animation_finished.connect(_on_animation_finished)
	

func _on_animation_finished(vars):
	hide()
	collision.disabled = true
	

func _on_static_body_2d_body_entered(body: Node2D):
	hit.emit(body)
