class_name Projectile
extends Area2D

enum ProjectileType {BULLET,FIREBALL}

@export var projectile_type: ProjectileType
@export var speed: float = 300.0
@export var damage_amount: int = 2
@export var damage_type: DamageService.DamageType = DamageService.DamageType.PHYSICAL
@export var lifetime: float = 3.0
@export var piercing: float = 1.0
@export var impact_sound: AudioStream

var direction: Vector2 = Vector2.ZERO
var hit_count: int = 0
var life_timer: SceneTreeTimer


func _ready():
	setup()
	

func setup():
	hit_count = 0
	life_timer = get_tree().create_timer(lifetime)
	life_timer.timeout.connect(_on_lifetime_timer_timeout)


func _on_lifetime_timer_timeout():
	remove()


func _physics_process(delta):
	position += (direction * speed * delta)
	

func remove():
	if is_instance_valid(self) and is_inside_tree():
		get_node("/root").remove_child(self)


func _on_area_entered(area):
	if hit_count >= piercing:
		if life_timer.timeout.is_connected(_on_lifetime_timer_timeout):
			life_timer.timeout.disconnect(_on_lifetime_timer_timeout)
		call_deferred("remove")
		return
		
	var body = area.get_parent()
	
	if body is Enemy:
		var attack = State.player.attack.total_value()
		body.take_damage(DamageService.Damage.new(damage_type, damage_amount + attack))
		hit_count += 1
