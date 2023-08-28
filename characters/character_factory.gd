extends RefCounted
class_name CharacterFactory

enum CharacterType {RAPTOR,ANKY,REX}


static func generate_character(type: CharacterType) -> Character:
	var character = Raptor.new()
	
	match type:
		CharacterType.RAPTOR:
			character = Raptor.new()
		CharacterType.REX:
			character = Rex.new()
		
	return character
