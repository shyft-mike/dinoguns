extends HBoxContainer


func _ready():
	Events.item_picked_up.connect(_on_item_picked_up)
	

func _on_item_picked_up(item):
	$Item1/TextureRect.texture = item.thumbnail_texture
	
