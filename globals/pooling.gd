extends Node


enum PoolType { BULLET, FIREBALL, POPUP, COMPY, AMBER, BIG_AMBER }

var _pools = {}


func add_to_pool(type: PoolType, instance: Object):
	if type not in _pools:
		_pools[type] = []

	_pools[type].append(instance)


func get_pool(type: PoolType) -> Array:
	if type not in _pools:
		return []

	return _pools[type]


## Attempts to get an item from the pool based on type. If there are none to get,
## calls the instance_func to get an instance of the object.
func get_from_pool(type: PoolType, instance_func: Callable):
	var pool: Array
	var instance: Node2D

	if type not in _pools:
		_pools[type] = []
	pool = _pools[type]

	if pool.size() > 0:
		instance = pool.pop_front()

		if is_instance_valid(instance):
			return instance
		else:
			print_debug("instance NOT valid", type, len(pool))
			instance = null

	if not instance:
		instance = instance_func.call()
		instance.tree_exiting.connect(add_to_pool.bind(type, instance))

	if not "setup" in instance:
		print_debug("No setup() for instance - ", instance)

	return instance


func clear():
	for pool in _pools.values():
		(pool as Array).clear()
