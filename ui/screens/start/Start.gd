extends Control

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var intro_audio: AudioStreamPlayer = $IntroAudioStreamPlayer

const RAPTOR_TEMPLATE = preload("res://actors/players/raptor/RaptorPlayer.tscn")


func _on_button_pressed():
	animation.play("start_game")


func start_game():
	#var new_player = CharacterFactory.generate_character_template(CharacterFactory.CharacterType.RAPTOR).instantiate()
	var new_player = RAPTOR_TEMPLATE.instantiate()

	Events.character_selected.emit(new_player)


func _unhandled_input(_event):
	if animation.is_playing() and Input.is_action_pressed("interact"):
		start_game()
