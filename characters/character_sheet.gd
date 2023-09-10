class_name CharacterSheet
extends RefCounted
## This class represents a character and their stats in the game, like a player, enemy, NPC.

var name: String = "-blank-"  ## The name of the character.
var type: int ## The CharacterType of the character.
var is_dead: bool  ## True if the character is dead.
var is_damagable: bool  ## True if the character can take damage.
var icon: Texture2D  ## The main icon of the character.
var stats: CharacterStats  ## The character's stats.
var inventory: CharacterInventory  ## The character's inventory.
var powerups  ## The character's powerups.


## Constructor.
func _init():
	setup()


## Sets the class up with it's default property values.
func setup():
	is_dead = false
	is_damagable = true
	stats = CharacterStats.new()
	inventory = CharacterInventory.new()


## Calculates the character's move speed.
func calc_move_speed(standard_move_speed: int) -> float:
	var player_speed = stats.move_speed.total_value()
	var speed_diff = player_speed - 10

	return standard_move_speed + (standard_move_speed * (speed_diff * 4 / 100.0))


## Causes the character to take damage, taking defense into account.
## NOTE: This should probably be more pure. Might make sense to have a
## "DamageCalculator" module or something.
func take_damage(attack_damage: int) -> int:
#	if not is_damagable:
#		return -1

	# TODO: calculate this in a cool way
	var total_damage

	if attack_damage >= stats.defense.total_value():
		total_damage = attack_damage
	else:
		total_damage = int(attack_damage * randf_range(0.7, 0.9))

	return take_true_damage(total_damage)


## Causes the character to take damage ignoring defense.
func take_true_damage(true_damage: int) -> int:
	stats.current_health -= true_damage
	
	# is this the player? probably better ways to do this
	if State.player.character == self:
		Events.player_health_changed.emit()

	if stats.current_health <= 0:
		is_dead = true

	return true_damage


## Causes the character to regenerate health.
func regen():
	if stats.current_health < stats.health.total_value():
		stats.current_health += stats.health_regen.total_value()
		if stats.current_health > stats.health.total_value():
			stats.current_health = stats.health.total_value()

		# only if they are a player, so maybe move to PlayerCharacter script?
		Events.player_health_changed.emit()
