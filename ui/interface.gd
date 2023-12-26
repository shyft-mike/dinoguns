extends Control


func _ready():
	Events.player_leveled_up.connect(_on_player_leveled_up)


func _on_player_leveled_up():
	pass
