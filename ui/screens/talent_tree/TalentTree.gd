extends Control


func _ready() -> void:
	Events.talent_updated.connect(_on_talent_updated)


func _on_talent_updated(talent_button: TalentButton):
	_update_available_skills(talent_button)


func _update_available_skills(root_talent: TalentButton):
	var talents = root_talent.get_children()

	for talent in talents:
		if talent is TalentButton:
			var disable_talent = root_talent.level == 0
			talent.set_talent_disabled(disable_talent)
			if disable_talent:
				talent.disable_children()
