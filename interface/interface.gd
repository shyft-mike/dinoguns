extends Control


func _ready():
	Events.player_leveled_up.connect(_on_player_leveled_up)
	

func _on_player_leveled_up():
	$CPUParticles2D.emitting = true
	$CPUParticles2D2.emitting = true
	await get_tree().create_timer(2).timeout
	$CPUParticles2D.emitting = false
	$CPUParticles2D2.emitting = false
