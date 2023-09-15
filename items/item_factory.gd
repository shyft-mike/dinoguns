class_name ItemFactory
extends Node2D


enum ItemType { AMBER, BIG_AMBER, MYSTERIOUS_GOO }


static func generate_item(type: ItemType) -> Item:
	var item

	match type:
		ItemType.AMBER:
			item = ResourceLoader.load("res://items/pickups/amber.tscn").instantiate()
		ItemType.BIG_AMBER:
			item = ResourceLoader.load("res://items/pickups/big_amber.tscn").instantiate()
		ItemType.MYSTERIOUS_GOO:
			assert(false, "Item MYSTERIOUS_GOO not yet implemented")

	return item
