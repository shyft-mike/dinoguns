class_name RaptorCharacterSheet
extends PlayerCharacterSheet


func setup():
	super.setup()
	
	name = "Raptor"
	icon = load("res://art/characters/RAPTOR_icon_64x64.png")
	is_selectable = true
	is_visible = true
	
	stats.attack.init(10)
	stats.defense.init(7)
	stats.health.init(90)
	stats.current_health = stats.health.total_value()
	stats.special.init(7)
	stats.move_speed.init(11)
	stats.attack_speed.init(15)
	stats.health_regen.init(5)
	
	inventory.add_slot(Slot.SlotType.ARM, Slot.SlotSize.MEDIUM)
	inventory.add_slot(Slot.SlotType.ARM, Slot.SlotSize.MEDIUM)
	inventory.add_slot(Slot.SlotType.NECK)
	inventory.add_slot(Slot.SlotType.BACK)
		
