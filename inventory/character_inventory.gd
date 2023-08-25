extends RefCounted
class_name CharacterInventory


var slots: Array[Slot]


func add_slot(slot_type: int, slot_size := Slot.SlotSize.NONE, active := true):
	var new_slot = Slot.new()
	new_slot.type = slot_type
	new_slot.size = slot_size
	new_slot.active = true	
	
	
func has_slot(slot_type: int, slot_size: int):
	var check_slot = func(slot: Slot):
		return slot.type == slot_type and slot.size == slot_size
	
	return slots.find(check_slot) != -1
