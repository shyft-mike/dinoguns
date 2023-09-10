class_name CharacterFactory
extends RefCounted

enum CharacterType { RAPTOR, ANKY, REX, COMPY, MEGA_COMPY }


static func generate_character_sheet(type: CharacterType) -> CharacterSheet:
	var character = RaptorCharacterSheet.new()

	match type:
		CharacterType.RAPTOR:
			character = RaptorCharacterSheet.new()
		CharacterType.REX:
			character = RexCharacterSheet.new()
		CharacterType.COMPY:
			character = CompyCharacterSheet.new()
		CharacterType.MEGA_COMPY:
			character = MegaCompyCharacterSheet.new()

	character.type = type

	return character


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
