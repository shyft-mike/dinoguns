class_name Projectile
extends Damager

@export var speed: float = 300.0
@export var lifetime: float = 3.0
@export var impact_sound: AudioStream

var direction: Vector2 = Vector2.ZERO
var elapsed_time: float = 0.0

var fire_effect: CPUParticles2D
var ice_effect: CPUParticles2D


func _ready():
	super()
	fire_effect = get_node_or_null("FireEffect")
	ice_effect = get_node_or_null("IceEffect")


func setup():
	hit_count = 0
	elapsed_time = 0.0


func set_damage_type(new_damage_type: DamageService.DamageType) -> void:
	damage_type = new_damage_type

	if damage_type == DamageService.DamageType.FIRE:
		if fire_effect:
			fire_effect.emitting = true
			fire_effect.amount = fire_effect.amount # could fix possible emission bug?
			fire_effect.show()
	elif damage_type == DamageService.DamageType.ICE:
		if ice_effect:
			ice_effect.emitting = true
			ice_effect.amount = ice_effect.amount # this does fix the emission bug...
			ice_effect.show()


func _physics_process(delta):
	if elapsed_time >= lifetime:
		remove()

	position += (direction * speed * delta)

	elapsed_time += delta


func remove():
	if fire_effect:
		fire_effect.emitting = false
		fire_effect.amount = fire_effect.amount # could fix possible emission bug?
		fire_effect.hide()
	if ice_effect:
		ice_effect.emitting = false
		ice_effect.amount = ice_effect.amount # this does fix the emission bug...
		ice_effect.hide()

	super.remove()
