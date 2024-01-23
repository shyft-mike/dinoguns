class_name Player extends Actor

@export var icon: Texture2D
@export var is_selectable: bool
@export var is_visible: bool

@onready var camera: Camera2D = $Camera2D
@onready var hand_marker: Marker2D = $Body/HandMarker
@onready var _upgrade_container: Node = $UpgradeContainer

var _upgrades: Array[Upgrade] = []


func _init():
	Events.experience_received.connect(_on_experience_received)
	Events.item_picked_up.connect(_on_item_picked_up)
	Events.player_health_changed.connect(_on_health_changed)


func _ready():
	setup()
	set_controller(PlayerController.new(self))

	_hurt_box.hurt_box_collided.connect(_on_hurt_box_collided)


func _physics_process(delta):
	_handle_movement()


func handle_damage(attack_damage: DamageService.Damage):
	if stat_manager.is_damagable:
		stat_manager.is_damagable = false
		flash(Color.RED)
		stat_manager.take_damage(attack_damage)
		await get_tree().create_timer(stat_manager.hit_invincibility_time).timeout
		stat_manager.is_damagable = true

	if stat_manager.is_dead:
		GameManager.game_over()


func _on_experience_received():
	flash()


func _on_item_picked_up(item):
	call_deferred("add_child", item)


func _on_health_changed(value: int):
	if value > 0:
		var popup = Pooling.get_from_pool(Pooling.PoolType.POPUP, func(): return number_popup_template.instantiate()) as NumberPopup
		SceneManager.current_scene.popup_container.add_child(popup)
		popup.health(str(value), global_position, 20, 0)


func _on_hurt_box_collided(area: Area2D):
	if area is HitBox:
		var damager = area.get_parent() as Damager
		if damager:
			handle_damage(damager.on_collide(self))

