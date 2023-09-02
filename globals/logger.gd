extends Node

var _messages = []


func _ready():
	Events.experience_received.connect(
		func(value):
			var message = "Received %d experience" % value
			_messages.append(message)
			Events.event_logged.emit(message)
	)
