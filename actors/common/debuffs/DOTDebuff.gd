class_name DOTDebuff
extends Debuff

signal dot_debuff_ticked(damage: DamageService.Damage)

@export var damage_type: DamageService.DamageType
@export var base_damage: int = 2
@export var damage_interval: float = 1.0

var damage_interval_ticks: float = 0.0


func _process(delta) -> void:
	if is_active:
		tick(delta)
	damage_interval_ticks += delta

	super._process(delta)


func tick(delta):
	if damage_interval_ticks >= damage_interval:
		var ticks = int(elapsed_time / damage_interval)
		dot_debuff_ticked.emit(DamageService.Damage.new(damage_type, base_damage + ticks))
		damage_interval_ticks = 0

	damage_interval_ticks += delta


func set_is_active(value: bool) -> void:
	pass


func get_is_active() -> bool:
	return is_active
