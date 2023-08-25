extends RefCounted
class_name Slot

enum SlotSize {SMALL,MEDIUM,LARGE,NONE}
enum SlotType {ARM,BACK,CHEST,NECK}

var active: bool: get = _get_active, set = _set_active
var icon: Texture2D: get = _get_icon, set = _set_icon
var size: SlotSize: get = _get_size, set = _set_size
var type: SlotType: get = _get_type, set = _set_type
var item


func _get_active():
	return active

func _set_active(value: bool):
	active = value

func _get_icon():
	return icon

func _set_icon(value: Texture2D):
	icon = value
	
func _get_size():
	return size

func _set_size(value: SlotSize):
	size = value

func _get_type():
	return type

func _set_type(value: SlotType):
	type = value
