class_name EnemyCharacterSheet
extends CharacterSheet


var drops: Array[ItemFactory.ItemType] = []


func add_drop(type: ItemFactory.ItemType, min_count: int = 1, max_count: int = 1):
	var num_to_add = randi_range(min_count, max_count)	
	
	for i in num_to_add:
		drops.append(type)
