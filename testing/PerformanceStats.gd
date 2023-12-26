extends VBoxContainer

var _ticks: int = 0
var _camera: Camera2D


func _ready():
	_camera = State.player.get_node("Camera2D")


func _handle_dino_stats(screen_rect: Rect2):
	var on_screen_count = 0
	var compies = get_tree().get_nodes_in_group("compy") as Array[Node2D]

	for node in compies:
		if screen_rect.has_point(node.global_position):
			on_screen_count += 1

	$DinoStats/OnScreenLabel.text = "Dinos on Screen: " + str(on_screen_count)
	$DinoStats/InPoolLabel.text = "Dinos in Pool: " + str(Pooling.get_pool(Pooling.PoolType.COMPY).size())
	$DinoStats/TotalLabel.text = "Total Dinos: " + str(compies.size())


func _handle_projectile_stats(screen_rect: Rect2):
	var on_screen_count = 0
	var projectiles = get_tree().get_nodes_in_group("projectile") as Array[Node2D]

	for node in projectiles:
		if screen_rect.has_point(node.global_position):
			on_screen_count += 1

	$ProjectileStats/OnScreenLabel.text = "Projectiles on Screen: " + str(on_screen_count)
	$ProjectileStats/InPoolLabel.text = "Projectiles in Pool: " + str(Pooling.get_pool(Pooling.PoolType.BULLET).size())
	$ProjectileStats/TotalLabel.text = "Total Projectiles: " + str(projectiles.size())


func _process(_delta):
	var fps = Engine.get_frames_per_second()
	$FPSLabel.text = "FPS: " + str(fps)

	if _ticks == 0 or _ticks % 30 == 0:
		var screen_rect = Rect2(
			_camera.get_global_transform().get_origin() - _camera.get_viewport_rect().size * 0.5,
			_camera.get_viewport_rect().size
		)

		_handle_dino_stats(screen_rect)
		_handle_projectile_stats(screen_rect)

	_ticks += 1
