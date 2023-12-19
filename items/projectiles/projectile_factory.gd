class_name ProjectileFactory
extends Node

static var bullet_template = preload("res://items/projectiles/bullet.tscn")
static var fireball_template = preload("res://items/projectiles/fireball.tscn")


static func generate(type: Projectile.ProjectileType) -> Projectile:
	var result

	match type:
		Projectile.ProjectileType.BULLET:
			result = Pooling.get_from_pool(
				Pooling.PoolType.BULLET, 
				func(): return bullet_template.instantiate())
		Projectile.ProjectileType.FIREBALL:
			result = Pooling.get_from_pool(
				Pooling.PoolType.FIREBALL,
				func(): return fireball_template.instantiate())

	return result
