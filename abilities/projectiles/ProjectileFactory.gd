class_name ProjectileFactory
extends Node

enum ProjectileType {BULLET,FIREBALL}

static var bullet_template = preload("res://abilities/projectiles/bullet.tscn")
static var fireball_template = preload("res://abilities/projectiles/fireball.tscn")


static func generate(type: ProjectileType) -> Projectile:
	var result: Projectile

	match type:
		ProjectileType.BULLET:
			result = Pooling.get_from_pool(
				Pooling.PoolType.BULLET,
				func(): return bullet_template.instantiate())
		ProjectileType.FIREBALL:
			result = Pooling.get_from_pool(
				Pooling.PoolType.FIREBALL,
				func(): return fireball_template.instantiate())

	result.setup()

	return result
