class_name ActorFactory extends Node

static var COMPY = preload("res://actors/enemies/compy/Compy.tscn")


static func generate_compy() -> Enemy:
	var compy: Enemy = COMPY.instantiate()

	return compy
