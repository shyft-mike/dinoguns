class_name Enemy
extends Character

enum EnemyState {PERSUING,RETREATING}

@onready var enemy: CharacterBody2D = $Enemy
@onready var enemy_sprite: AnimatedSprite2D = $Enemy/AnimatedSprite2D

@export var spray_template: PackedScene
@export var drops: Array[Drop] = []

var current_state: EnemyState = EnemyState.PERSUING
var last_sighting: Vector2
var original_drops

func _ready():
	setup()


func setup():
	super.setup()
	
	enemy.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	enemy_sprite.play()
	
	
func _physics_process(delta):
	var direction_to_player = enemy.global_position.direction_to(State.player.global_position)
	var distance_to_player = enemy.global_position.distance_to(State.player.global_position)
	
	var dot_product = direction_to_player.normalized().dot(State.player.global_position.normalized())
	
	if dot_product <= 0:
		enemy_sprite.flip_h = true
	else:
		enemy_sprite.flip_h = false
	
	match current_state:
		Enemy.EnemyState.PERSUING:
			if distance_to_player > 50:
				enemy.velocity = direction_to_player * CharacterService.calc_move_speed(self)
			if distance_to_player <= 50:
				current_state = Enemy.EnemyState.RETREATING
				last_sighting = State.player.global_position
				enemy.velocity = -direction_to_player * CharacterService.calc_move_speed(self) * 1.1
		
		Enemy.EnemyState.RETREATING:
			enemy_sprite.flip_h = not enemy_sprite.flip_h
			enemy.velocity = -enemy.global_position.direction_to(last_sighting) * CharacterService.calc_move_speed(self) * 1.1
			if enemy.global_position.distance_to(last_sighting) > 300:
				current_state = Enemy.EnemyState.PERSUING
		
	enemy.move_and_slide()


func take_damage(attack_damage: int):
	var damage_done = CharacterService.take_damage(self, attack_damage)
	
	_flash()
	_show_damage_popup(damage_done)
	_spray()
	
	if is_dead:
		_drop_items()
		remove()


func _spray():
	if spray_template:
		var spray = spray_template.instantiate()
		spray.rotation = rotation
		
		add_child(spray)
		await get_tree().create_timer(0.3).timeout
		spray.queue_free()
		

func _drop_items():
	for drop in drops:
		var current_drop_rate = drop.drop_rate
		while current_drop_rate > 0:
			if randf() < current_drop_rate:
				var item_to_drop = _get_drop_item(drop)		
				item_to_drop.position = enemy.global_position
				SceneManager.current_scene.items_container.call_deferred("add_child", item_to_drop)
				item_to_drop.call_deferred("launch")
			current_drop_rate -= 1.0

#		print_debug("enemy gpos: ", enemy.global_position)
#		print_debug("enemy pos: ", enemy.position)
#		print_debug("self gpos: ", self.global_position)
#		print_debug("self pos: ", self.position)
		

func _get_drop_item(drop: Drop) -> Item:
	var pool_type
	
	match drop.item_type:
		ItemFactory.ItemType.AMBER:
			pool_type = Pooling.PoolType.AMBER
		ItemFactory.ItemType.BIG_AMBER:
			pool_type = Pooling.PoolType.BIG_AMBER
	
	return Pooling.get_from_pool(pool_type, ItemFactory.generate_item.bind(drop.item_type))
	

func _flash():
	ShaderEffects.flash(enemy_sprite.material, true, Color.RED)
	await get_tree().create_timer(0.1).timeout
	ShaderEffects.flash(enemy_sprite.material, false)
	
	
func _show_damage_popup(damage_done: int):
	var popup = Pooling.get_from_pool(Pooling.PoolType.POPUP, func(): return number_popup_template.instantiate()) as NumberPopup
	SceneManager.current_scene.popup_container.add_child(popup)
	popup.damage(str(damage_done), enemy.global_position, 0, 0)
	
	
func remove():
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)
