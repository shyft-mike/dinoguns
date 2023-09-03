extends RefCounted
class_name Character

var name: String = "-blank-"
var icon: Texture2D = CanvasTexture.new()
var stats: CharacterStats = CharacterStats.new()
var inventory: CharacterInventory = CharacterInventory.new()
var powerups


func calc_move_speed(standard_move_speed: int) -> float:
	var player_speed = stats.move_speed.total_value()
	var speed_diff = player_speed - 10
	
	return standard_move_speed + (standard_move_speed * (speed_diff * 4 / 100))


func take_damage(attack_damage: int):
	stats.current_health -= attack_damage


func regen():
	if stats.current_health < stats.health.total_value():
		stats.current_health += stats.health_regen.total_value()
		if stats.current_health > stats.health.total_value(): 
			stats.current_health = stats.health.total_value()
		
		# only if they are a player, so maybe move to PlayerCharacter script?
		Events.player_health_changed.emit()
			
		# if health less than zero, they'd already be dead and not regen'ing
#		if stats.current_health <= 0:
#			stats.current_health = 0
