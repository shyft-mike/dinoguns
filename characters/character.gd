extends RefCounted
class_name Character

var name: String = "Raptor"
var icon: Texture2D = CanvasTexture.new()
var stats: CharacterStats = CharacterStats.new()
var inventory: CharacterInventory = CharacterInventory.new()
var powerups
