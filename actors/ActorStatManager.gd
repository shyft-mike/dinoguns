class_name ActorStatManager
extends Resource

@export var base_attack: int
@export var base_defense: int
@export var base_health: int
@export var base_move_speed: int
@export var base_attack_speed: int
@export var base_health_regen: int
@export var base_fire_resist: int
@export var hit_invincibility_time: float = 0.2

var current_health: int

var attack: Stat
var defense: Stat
var health: Stat
var move_speed: Stat
var attack_speed: Stat
var health_regen: Stat
var fire_resist: Stat

var is_dead: bool         ## True if the character is dead.
var is_damagable: bool    ## True if the character can take damage.


func setup():
	attack = Stat.create("Attack", base_attack)
	defense = Stat.create("Defense", base_defense)
	health = Stat.create("Health", base_health)
	move_speed = Stat.create("Move Speed", base_move_speed)
	attack_speed = Stat.create("Attack Speed", base_attack_speed)
	health_regen = Stat.create("Health Regen", base_health_regen)
	fire_resist = Stat.create("Fire Resistance", base_fire_resist)

	current_health = health.total_value()

	is_dead = false
	is_damagable = true


func get_health_percent() -> float:
	var health_percent = float(current_health) / health.total_value() * 100.0
	return health_percent


## Calculates the character's move speed.
func get_move_speed() -> float:
	return move_speed.total_value()


func take_damage(damage: DamageService.Damage) -> int:
	var damage_taken = DamageService.calc_damage(self, damage)

	current_health -= damage_taken

	if current_health <= 0:
		is_dead = true

	return damage_taken


## Causes the character to regenerate health.
func regen() -> int:
	if current_health < health.total_value():
		current_health += health_regen.total_value()
		if current_health > health.total_value():
			current_health = health.total_value()

		return health_regen.total_value()
	return 0


func add_experience(value: int):
	pass
