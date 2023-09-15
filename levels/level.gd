class_name Level
extends Node2D

@onready var map: TileMap = $Map
@onready var enemies_container: Node2D = $Map/Enemies
@onready var items_container: Node2D = $Map/Items
@onready var players_container: Node2D = $Map/Players
@onready var damage_popup_container: Node2D = $Map/DamagePopup


func _ready():
	Events.time_of_day_changed.connect(_on_time_of_day_changed)
	

func _on_time_of_day_changed(new_color):
	$DirectionalLight2D.color = new_color
