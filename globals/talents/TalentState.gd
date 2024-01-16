class_name TalentState
extends Resource


@export var raptor_talent_entry: PlayerTalentEntry = PlayerTalentEntry.new("raptor")


func add() -> void:
	raptor_talent_entry.selected_talents.append("test")
