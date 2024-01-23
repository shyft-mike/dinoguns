class_name ActorFactory extends Node

enum PlayerType {RAPTOR}
enum EnemyType {COMPY}

static var COMPY = preload("res://actors/enemies/compy/Compy.tscn")
static var RAPTOR = preload("res://actors/players/raptor/RaptorPlayer.tscn")


static func generate_enemy(type: EnemyType) -> Enemy:
	var enemy: Enemy

	match type:
		EnemyType.COMPY:
			enemy = COMPY.instantiate()

	return enemy


static func generate_player(type: PlayerType) -> Player:
	var player: Player

	match type:
		PlayerType.RAPTOR:
			player = RAPTOR.instantiate()

	return player


static func get_player_characters() -> Array[Player]:
	var player_characters: Array[Player] = []
	for player_type in PlayerType.values():
		player_characters.append(generate_player(player_type))
	return player_characters
