extends PanelContainer

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var intro_audio: AudioStreamPlayer = $IntroAudioStreamPlayer


func _on_button_pressed():
	animation.play("start_game")


func start_game():
	var new_player = CharacterFactory.generate_character_template(CharacterFactory.CharacterType.RAPTOR).instantiate()
	
	Events.character_selected.emit(new_player)


func _unhandled_input(event):
	if animation.is_playing() and Input.is_action_pressed("attack"):
		start_game()
