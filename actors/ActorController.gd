class_name ActorController extends Node

var actor: Actor
var move_command: MoveCommand = MoveCommand.new()


func _init(actor: Actor) -> void:
	self.actor = actor
