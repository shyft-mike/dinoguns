class_name Character
extends Node2D

@export var icon: Texture2D

@export_group("Stats")
@export var base_attack: int
@export var base_defense: int
@export var base_health: int
@export var base_move_speed: int
@export var base_attack_speed: int
@export var base_health_regen: int
@export var hit_invincibility_time: float = 0.2

var attack: Stat
var defense: Stat
var health: Stat
var move_speed: Stat
var attack_speed: Stat
var health_regen: Stat

var current_health: int
var is_dead: bool  ## True if the character is dead.
var is_damagable: bool  ## True if the character can take damage.
var is_player: bool


func setup():
	attack = Stat.create("Attack", base_attack)
	defense = Stat.create("Defense", base_defense)
	health = Stat.create("Health", base_health)
	move_speed = Stat.create("Move Speed", base_move_speed)
	attack_speed = Stat.create("Attack Speed", base_attack_speed)
	health_regen = Stat.create("Health Regen", base_health_regen)

	current_health = health.total_value()
