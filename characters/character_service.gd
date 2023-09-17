class_name CharacterService
extends RefCounted


static func add_experience(character: Character, value: int):
	# TODO: handle multiple level ups at once
	character.experience += value
	
	if character.is_player:
		Events.experience_received.emit()

	if character.experience >= character.to_next_level:
		character.level += 1
		character.experience = character.experience - character.to_next_level
		character.to_next_level = _experience_for_level(character, character.level)
		
		if character.is_player:
			Events.player_leveled_up.emit()


static func _experience_for_level(character: Character, level: int) -> int:
	return int(character.base_experience * pow(level, 2.5))


## Calculates the character's move speed.
static func calc_move_speed(character: Character, standard_move_speed: int = State.standard_move_speed) -> float:
	var player_speed = character.move_speed.total_value()
	var speed_diff = player_speed - 10

	return standard_move_speed + (standard_move_speed * (speed_diff * 4 / 100.0))


## Causes the character to take damage, taking defense into account.
## NOTE: This should probably be more pure. Might make sense to have a
## "DamageCalculator" module or something.
static func take_damage(character: Character, attack_damage: int) -> int:
#	if not is_damagable:
#		return -1

	# TODO: calculate this in a cool way
	var total_damage

	if attack_damage >= character.defense.total_value():
		total_damage = attack_damage
	else:
		total_damage = int(attack_damage * randf_range(0.7, 0.9))

	return take_true_damage(character, total_damage)


## Causes the character to take damage ignoring defense.
static func take_true_damage(character: Character, true_damage: int) -> int:
	character.current_health -= true_damage
	
	if character.is_player:
		Events.player_health_changed.emit(-true_damage)

	if character.current_health <= 0:
		character.is_dead = true

	return true_damage


## Causes the character to regenerate health.
static func regen(character: Character):
	if character.current_health < character.health.total_value():
		character.current_health += character.health_regen.total_value()
		if character.current_health > character.health.total_value():
			character.current_health = character.health.total_value()

		if character.is_player:
			Events.player_health_changed.emit(character.health_regen.total_value())
