class_name PlayerTalentEntry
extends Resource


@export var player_type: String
@export var selected_talents: Array[String]


func _init(player_type) -> void:
	self.player_type = player_type
	self.selected_talents = []
