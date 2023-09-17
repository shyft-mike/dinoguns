class_name ItemFactory
extends Node2D

enum ItemType { AMBER, BIG_AMBER, MYSTERIOUS_GOO }

static var amber_template = preload("res://items/pickups/amber.tscn")
static var big_amber_template = preload("res://items/pickups/big_amber.tscn")


static func generate_item(type: ItemType) -> Item:
	var item

	match type:
		ItemType.AMBER:
			item = amber_template.instantiate()
		ItemType.BIG_AMBER:
			item = big_amber_template.instantiate()
		ItemType.MYSTERIOUS_GOO:
			assert(false, "Item MYSTERIOUS_GOO not yet implemented")

	return item
