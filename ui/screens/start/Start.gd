extends Control

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var intro_audio: AudioStreamPlayer = $IntroAudioStreamPlayer


func _on_button_pressed():
	animation.play("start_game")


func start_game():
	#var new_player = RAPTOR_TEMPLATE.instantiate()
#
	#Events.character_selected.emit(new_player)
	SceneManager.change_scene(SceneManager.CHARACTER_SELECT_SCENE)


func _unhandled_input(_event):
	if animation.is_playing() and Input.is_action_pressed("interact"):
		start_game()
