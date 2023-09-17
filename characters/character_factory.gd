class_name CharacterFactory
extends RefCounted

enum CharacterType { RAPTOR, ANKY, REX, COMPY, MEGA_COMPY }

static var raptor_template = preload("res://characters/player/raptor/raptor_player.tscn")
static var compy_template = preload("res://characters/enemies/compy.tscn")
static var mega_compy_template = preload("res://characters/enemies/mega_compy.tscn")


static func generate_character_template(type: CharacterType) -> PackedScene:
	var template

	match type:
		CharacterType.RAPTOR:
			template = raptor_template
		CharacterType.REX:
			assert(false, "Player REX not yet implemented")
		CharacterType.COMPY:
			template = compy_template
		CharacterType.MEGA_COMPY:
			template = mega_compy_template

	return template
