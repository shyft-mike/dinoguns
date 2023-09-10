extends EnemyCharacterSheet
class_name MegaCompyCharacterSheet


func setup():
	super.setup()
		
	name = "MegaCompy"
	stats.attack.init(10)
	stats.defense.init(15)
	stats.health.init(200)
	stats.current_health = stats.health.total_value()
	stats.special.init(10)
	stats.move_speed.init(11)
	stats.attack_speed.init(10)
	
	add_drop(ItemFactory.ItemType.AMBER, 3, 7)
	add_drop(ItemFactory.ItemType.BIG_AMBER, 2, 4)
