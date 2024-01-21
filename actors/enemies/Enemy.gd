class_name Enemy extends Actor

signal has_died (actor: Actor)

enum EnemyState {PERSUING,RETREATING,STOPPED}

@export var spray_template: PackedScene
@export var drops: Array[Drop] = []

@onready var body_damager: Damager = $Body/BodyDamager

var current_state: EnemyState = EnemyState.PERSUING
var _frame_count: int = 0


func _ready():
	setup()
	set_controller(EnemyController.new(self))

	body_damager.user = self

	_hurt_box.hurt_box_collided.connect(_on_hurt_box_collided)
	_debuff_manager.damage_ticked.connect(handle_damage)
	_debuff_manager.debuff_removed.connect(_on_debuff_removed)


func setup():
	super.setup()
	$HealthBar.value = 100
	current_state = EnemyState.PERSUING
	_debuff_manager.reset()
	_reset_animation()


func _reset_animation():
	# blech, why do i have to do this when i have a "RESET" track?
	scale = Vector2(1,1)
	_body_sprite.modulate = Color.WHITE


func _handle_movement():
	if current_state == EnemyState.STOPPED:
		return
	super._handle_movement()


func _physics_process(_delta):
	if _frame_count == 0 or _frame_count % 2 == 0:
		_handle_movement()
	_frame_count += 1


func handle_damage(damage: DamageService.Damage):
	if not damage:
		return
	if stat_manager.is_dead:
		return

	var damage_done = stat_manager.take_damage(damage)

	if damage_done > 0:
		$HealthBar.value = stat_manager.get_health_percent()
		flash(Color.RED)
		show_damage_popup(damage_done, damage.damage_type)
		spray()

	if stat_manager.is_dead:
		_debuff_manager.reset()
		current_state = EnemyState.STOPPED
		if _animation_player:
			_animation_player.play("die")
		else:
			die()


func die():
	_drop_items()
	remove()
	has_died.emit(self)


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

	return Pooling.get_from_pool(pool_type, ItemFactory.create.bind(drop.item_type))


func show_damage_popup(damage_done: int, damage_type: DamageService.DamageType):
	var popup = Pooling.get_from_pool(Pooling.PoolType.POPUP, func(): return number_popup_template.instantiate()) as NumberPopup
	SceneManager.current_scene.popup_container.add_child(popup)
	popup.damage(str(damage_done), _popup_marker.global_position, 20, 0, damage_type)


func _on_hurt_box_collided(area: Area2D):
	if area is HitBox:
		if area.damager.damage_type == DamageService.DamageType.FIRE:
			if randi() % 5 == 0:
				_debuff_manager.is_burning = true
		if area.damager.damage_type == DamageService.DamageType.ICE:
			if randi() % 3 == 0:
				apply_frozen()

		handle_damage(area.damager.on_collide(self))


func _on_debuff_removed(debuff: Debuff) -> void:
	if debuff is IceDebuff:
		_body_sprite.modulate = Color.WHITE
		_animation_player.speed_scale = 1


func remove():
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)
