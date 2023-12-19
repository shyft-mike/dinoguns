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

	return standard_move_speed + player_speed


static func take_damage(character: Character, damage: DamageService.Damage) -> int:
	var damage_taken = DamageService.calc_damage(character, damage)

	character.current_health -= damage_taken
	
	if character.is_player:
		Events.player_health_changed.emit(-damage_taken)

	if character.current_health <= 0:
		character.is_dead = true

	return damage_taken


## Causes the character to regenerate health.
static func regen(character: Character):
	if character.current_health < character.health.total_value():
		character.current_health += character.health_regen.total_value()
		if character.current_health > character.health.total_value():
			character.current_health = character.health.total_value()

		if character.is_player:
			Events.player_health_changed.emit(character.health_regen.total_value())
