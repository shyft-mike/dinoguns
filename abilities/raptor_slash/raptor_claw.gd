extends Area2D

@export var damage_type: DamageService.DamageType
@export var damage_amount: int = 10


func _on_area_entered(area):
	var body = area.get_parent()
	
	if body is Enemy:
		var attack = State.player.attack.total_value()
		body.take_damage(DamageService.Damage.new(damage_type, damage_amount + attack))
