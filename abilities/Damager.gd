class_name Damager
extends Node2D

@export var damage_type: DamageService.DamageType
@export var base_damage: int = 10
@export var piercing: int = 0

@onready var hit_box: HitBox = $HitBox

var attached_modifiers: Array[Modifier] = []

var user: Actor
var hit_count: int = 0


func _ready():
	hit_box.damager = self


func on_collide(collided_actor: Actor) -> DamageService.Damage:
	if piercing != 0 and hit_count == piercing:
		call_deferred("remove")
		return

	for modifier in attached_modifiers:
		modifier.modify_damager_collide(self, collided_actor)

	hit_count += 1

	return DamageService.Damage.new(damage_type, base_damage + user.stat_manager.attack.total_value())


func remove():
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)
