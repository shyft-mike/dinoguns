class_name CharacterFactory
extends RefCounted

enum CharacterType { RAPTOR, ANKY, REX, COMPY, MEGA_COMPY }


static func generate_character_template(type: CharacterType) -> PackedScene:
	var template

	match type:
		CharacterType.RAPTOR:
			template = ResourceLoader.load("res://characters/player/raptor/raptor_player.tscn")
		CharacterType.REX:
			assert(false, "Player REX not yet implemented")
		CharacterType.COMPY:
			template = ResourceLoader.load("res://characters/enemies/compy.tscn")
		CharacterType.MEGA_COMPY:
			template = ResourceLoader.load("res://characters/enemies/mega_compy.tscn")

	return template
