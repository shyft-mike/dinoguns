extends Node


enum PoolType { BULLET, FIREBALL, POPUP, COMPY, AMBER, BIG_AMBER }

var _pools = {}


func add_to_pool(type: PoolType, instance: Object):
	if type not in _pools:
		_pools[type] = []
		
	_pools[type].append(instance)


## Attempts to get an item from the pool based on type. If there are none to get,
## calls the instance_func to get an instance of the object.
func get_from_pool(type: PoolType, instance_func: Callable):
	var pool
	if type not in _pools:
		_pools[type] = []
	pool = _pools[type]
	
	if pool.size() > 0:
		var instance = pool.pop_front()
		
		if is_instance_valid(instance):
			return instance
		else:
			print_debug("instance NOT valid", type, len(pool))
	
	var instance = instance_func.call()
	
	instance.tree_exiting.connect(func(): add_to_pool(type, instance))
	
	return instance


func clear():
	for pool in _pools.values():
		(pool as Array).clear()
