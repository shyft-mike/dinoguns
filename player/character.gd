extends RefCounted
class_name Character

var name: String = ""
var level: int = 0
var experience: int = 0
var icon: Texture2D = CanvasTexture.new()
var is_visible: bool = false
var is_selectable: bool = false
var stats: CharacterStats = CharacterStats.new()
var powerups
var equipment
var inventory
