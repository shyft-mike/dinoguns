extends VBoxContainer


func _ready():
	Events.event_logged.connect(_on_event_logged)


func _on_event_logged(message):
	var message_label = Label.new()
	message_label.text = message
	$MarginContainer.add_child(message_label)
