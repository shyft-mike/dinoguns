extends Item


func on_pickup():
	var gun = ResourceLoader.load("res://items/weapons/gun.tscn").instantiate()
	
	Events.item_picked_up.emit(gun)
	remove()
