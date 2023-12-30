class_name ItemFactory
extends Node2D

static var amber_template = preload("res://items/exp/amber.tscn")
static var big_amber_template = preload("res://items/exp/big_amber.tscn")
static var uzi_template = preload("res://items/weapons/uzi/UziItem.tscn")


static func create(type: ItemUtility.ItemType) -> Item:
	var item: Item

	match type:
		ItemUtility.ItemType.AMBER:
			item = amber_template.instantiate()
		ItemUtility.ItemType.BIG_AMBER:
			item = big_amber_template.instantiate()
		ItemUtility.ItemType.UZI:
			item = uzi_template.instantiate()

	return item
