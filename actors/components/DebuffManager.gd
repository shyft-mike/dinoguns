class_name DebuffManager
extends Node2D

signal damage_ticked(damage: DamageService.Damage)
signal debuff_removed(debuff: Debuff)

@onready var burn: BurnDebuff = $BurnDebuff
@onready var ice: IceDebuff = $IceDebuff


var is_burning: bool = false:
	set(value):
		burn.is_active = value
	get:
		return burn.is_active


var is_frozen: bool = false:
	set(value):
		ice.is_active = value
	get:
		return ice.is_active


func reset() -> void:
	burn.is_active = false
	ice.is_active = false


func _on_burn_debuff_ticked(damage: DamageService.Damage) -> void:
	damage_ticked.emit(damage)


func _on_ice_debuff_removed() -> void:
	debuff_removed.emit(ice)
