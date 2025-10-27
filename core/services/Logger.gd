extends Node

var _messages = []


func _ready():
	Events.experience_received.connect(
		func():
			var message = "Received experience"
			_messages.append(message)
			Events.event_logged.emit(message)
	)
