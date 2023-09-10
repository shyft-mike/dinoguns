class_name CompyCharacterSheet
extends EnemyCharacterSheet
	

func setup():
	super.setup()
	
	name = "Compy"
	stats.attack.init(5)
	stats.defense.init(3)
	stats.health.init(20)
	stats.current_health = stats.health.total_value()
	stats.special.init(5)
	stats.move_speed.init(7)
	stats.attack_speed.init(7)
	
	add_drop(ItemFactory.ItemType.AMBER, 1, 3)
	add_drop(ItemFactory.ItemType.BIG_AMBER, 0, 1)
