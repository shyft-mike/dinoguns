extends Control

@onready var info_button: TextureButton = $InfoButton


func _ready():
	Events.player_leveled_up.connect(_on_player_leveled_up)


func _on_player_leveled_up():
	pass


func _on_info_button_mouse_entered() -> void:
	ShaderEffects.highlight(info_button.material, true, Color("2a0045"))


func _on_info_button_mouse_exited() -> void:
		ShaderEffects.highlight(info_button.material, false)
