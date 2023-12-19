class_name ItemFactory
extends Node2D

static var amber_template = preload("res://items/exp/amber.tscn")
static var big_amber_template = preload("res://items/exp/big_amber.tscn")


static func generate_item(type: ItemUtility.ItemType) -> Item:
	var item

	match type:
		ItemUtility.ItemType.AMBER:
			item = amber_template.instantiate()
		ItemUtility.ItemType.BIG_AMBER:
			item = big_amber_template.instantiate()
		ItemUtility.ItemType.MYSTERIOUS_GOO:
			assert(false, "Item MYSTERIOUS_GOO not yet implemented")

	return item
