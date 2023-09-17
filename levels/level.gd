class_name Level
extends Node2D

@onready var map: TileMap = $Map
@onready var items_container: Node2D = $Map/Items
@onready var spawns_container: Node2D = $Map/Spawns
@onready var popup_container: Node2D = $Map/Popups

@export var spawn_pattern_path: String

var spawn_flow: SpawnFlow


func _ready():
	Events.time_of_day_changed.connect(_on_time_of_day_changed)
	
	_parse_spawn_pattern(spawn_pattern_path)
	

func _on_time_of_day_changed(new_color):
	$DirectionalLight2D.color = new_color


func _parse_spawn_pattern(spawn_pattern_filename: String):
	var spawn_pattern_file = FileAccess.open(spawn_pattern_filename, FileAccess.READ)
	
	spawn_flow = SpawnFlow.new(spawn_pattern_file)
