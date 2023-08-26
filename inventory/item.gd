extends RefCounted

enum ItemType {WEAPON,POWERUP}

var name := ""
var instance: PackedScene
var type: ItemType
var slot_type: int
var slot_size: int


func on_pickup():
	pass
