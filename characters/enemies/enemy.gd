class_name Enemy
extends Character

enum EnemyState {PERSUING,RETREATING}

@export var spray_template: PackedScene
@export var drops: Array[Drop] = []

var current_state: EnemyState = EnemyState.PERSUING
var last_sighting: Vector2

# Abilities
var move: Move


func _ready():
	setup()


func setup():
	super.setup()
	
	move = load_ability("move")
	
	
func _physics_process(delta):
	var direction_to_player = global_position.direction_to(State.player.global_position)
	var distance_to_player = global_position.distance_to(State.player.global_position)
	
	animated_sprite.flip_h = direction_to_player.x < 0
	
	match current_state:
		EnemyState.PERSUING:
			if distance_to_player > 50:
				move.execute(self, direction_to_player)
			if distance_to_player <= 50:
				current_state = Enemy.EnemyState.RETREATING
				last_sighting = State.player.global_position
				move.execute(self, -direction_to_player * 1.1)
				
		EnemyState.RETREATING:
			move.execute(self, -global_position.direction_to(last_sighting) * 1.1)
			if global_position.distance_to(last_sighting) > 300:
				current_state = Enemy.EnemyState.PERSUING
	
	if velocity.length() < 0.1:
		animated_sprite.play("default")
	else:
		animated_sprite.play("walk")


func take_damage(attack_damage: int):
	var damage_done = CharacterService.take_damage(self, attack_damage)
	
	flash(Color.RED)
	show_damage_popup(damage_done)
	spray()
	
	if is_dead:
		_drop_items()
		remove()


func spray():
	if spray_template:
		var spray_instance = spray_template.instantiate()
		spray_instance.rotation = rotation
		
		add_child(spray_instance)
		await get_tree().create_timer(0.3).timeout
		spray_instance.queue_free()
		

func _drop_items():
	for drop in drops:
		var current_drop_rate = drop.drop_rate
		while current_drop_rate > 0:
			if randf() < current_drop_rate:
				var item_to_drop = _get_drop_item(drop)		
				item_to_drop.position = global_position
				SceneManager.current_scene.items_container.call_deferred("add_child", item_to_drop)
				item_to_drop.call_deferred("launch")
			current_drop_rate -= 1.0
		

func _get_drop_item(drop: Drop) -> Item:
	var pool_type
	
	match drop.item_type:
		ItemFactory.ItemType.AMBER:
			pool_type = Pooling.PoolType.AMBER
		ItemFactory.ItemType.BIG_AMBER:
			pool_type = Pooling.PoolType.BIG_AMBER
	
	return Pooling.get_from_pool(pool_type, ItemFactory.generate_item.bind(drop.item_type))
		
	
func show_damage_popup(damage_done: int):
	var popup = Pooling.get_from_pool(Pooling.PoolType.POPUP, func(): return number_popup_template.instantiate()) as NumberPopup
	SceneManager.current_scene.popup_container.add_child(popup)
	popup.damage(str(damage_done), global_position, 0, 0)
	
	
func remove():
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)
