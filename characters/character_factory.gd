extends RefCounted
class_name CharacterFactory

enum CharacterType {RAPTOR,ANKY,REX,COMPY}


static func generate_character(type: CharacterType) -> Character:
	var character = Raptor.new()
	
	match type:
		CharacterType.RAPTOR:
			character = Raptor.new()
		CharacterType.REX:
			character = Rex.new()
		CharacterType.COMPY:
			character = Compy.new()
		
	return character
