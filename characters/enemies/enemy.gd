class_name Enemy
extends Character

enum EnemyState {PERSUING,RETREATING,STOPPED}

@onready var hit_area_2d: Area2D = $HitArea2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var spray_template: PackedScene
@export var drops: Array[Drop] = []

var current_state: EnemyState = EnemyState.PERSUING
var last_sighting: Vector2
var flipped: bool = false

var remaining_cycles: int = 0

# Abilities
var move: Move


func _ready():
	setup()


func setup():
	super.setup()
	
#	move = load_ability("move")
	
	
func _physics_process(delta):
	if current_state == EnemyState.STOPPED:
		return
	
	var direction_to_player = global_position.direction_to(State.player.global_position)
	
	# flip the entire node depending on where they should face
	# this flips collisions and mount points, etc
	if direction_to_player.x < 0:
		if not flipped:
			scale *= Vector2(-1, 1)
			flipped = true
	elif flipped:
		scale *= Vector2(-1, 1)
		flipped = false
	
	if remaining_cycles == 0:
		remaining_cycles = randi_range(30, 90)
		last_sighting = State.player.global_position
	
	var distance_to_player = global_position.distance_to(last_sighting)	
	
	if distance_to_player > 50:
		var new_direction = global_position.direction_to(last_sighting).normalized()
		new_direction.x += randf_range(-8.0, 8.0) * delta
		new_direction.y += randf_range(-8.0, 8.0) * delta
		abilities.execute(Ability.AbilityType.MOVE, {direction=new_direction, delta=delta})
		
	remaining_cycles -= 1
		
	if linear_velocity.length() < 0.1:
		animated_sprite.play("default")
	else:
		animated_sprite.play("walk")


func take_damage(damage: DamageService.Damage):
	if is_dead:
		return
	
	var damage_done = CharacterService.take_damage(self, damage)
	
	flash(Color.RED)
	show_damage_popup(damage_done)
	spray()
	
	if is_dead:
		current_state = EnemyState.STOPPED
		if animation_player:
			animation_player.play("die")
		else:
			die()


func die():
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
		ItemUtility.ItemType.AMBER:
			pool_type = Pooling.PoolType.AMBER
		ItemUtility.ItemType.BIG_AMBER:
			pool_type = Pooling.PoolType.BIG_AMBER
	
	return Pooling.get_from_pool(pool_type, ItemFactory.generate_item.bind(drop.item_type))
		
	
func show_damage_popup(damage_done: int):
	var popup = Pooling.get_from_pool(Pooling.PoolType.POPUP, func(): return number_popup_template.instantiate()) as NumberPopup
	SceneManager.current_scene.popup_container.add_child(popup)
	popup.damage(str(damage_done), global_position, 20, 0)
	
	
func remove():
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)
