class_name Character
extends Area2D

@export var icon: Texture2D

@export var number_popup_template: PackedScene = preload("res://interface/number_popup.tscn")

@export_group("Stats")
@export var base_attack: int
@export var base_defense: int
@export var base_health: int
@export var base_move_speed: int
@export var base_attack_speed: int
@export var base_health_regen: int
@export var hit_invincibility_time: float = 0.2

@onready var abilities: Node = $Abilities
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var attack: Stat
var defense: Stat
var health: Stat
var move_speed: Stat
var attack_speed: Stat
var health_regen: Stat

var current_health: int
var is_dead: bool         ## True if the character is dead.
var is_damagable: bool    ## True if the character can take damage.
var is_player: bool
var velocity: Vector2 = Vector2.ZERO


func setup():
	attack = Stat.create("Attack", base_attack)
	defense = Stat.create("Defense", base_defense)
	health = Stat.create("Health", base_health)
	move_speed = Stat.create("Move Speed", base_move_speed)
	attack_speed = Stat.create("Attack Speed", base_attack_speed)
	health_regen = Stat.create("Health Regen", base_health_regen)

	current_health = health.total_value()
	
	is_dead = false
	is_damagable = true


func load_ability(name: String):
	var scene = ResourceLoader.load("res://characters/abilities/" + name + "/" + name + ".tscn")
	var scene_instance = scene.instantiate()
	abilities.add_child(scene_instance)
	return scene_instance
	
	
func flash(color: Color = Color.WHITE):
	ShaderEffects.flash(animated_sprite.material, true, color)
	await get_tree().create_timer(0.1).timeout
	ShaderEffects.flash(animated_sprite.material, false, color)
