class_name Player
extends Character

@onready var player_area_2d: Area2D = $Player
@onready var pickup_field_collision: CollisionShape2D = $Player/PickupField/CollisionShape2D
@onready var mutations: Node = $Player/Mutations
@onready var abilities: Node = $Player/Abilities

@export var base_experience: int = 10
@export var base_pickup_field_radius: int = 50

@export var is_selectable: bool
@export var is_visible: bool

var level: int = 1
var experience: int = 0
var total_experience: int = 0
var to_next_level: int = base_experience


func _init():
	Events.experience_received.connect(_on_experience_received)
	Events.item_picked_up.connect(_on_item_picked_up)
	Events.player_health_changed.connect(_on_health_changed)
	

func _ready():
	setup()


func setup():
	super.setup()
	
	level = 1
	experience = 0
	total_experience = 0
	to_next_level = base_experience
	pickup_field_collision.shape.radius = base_pickup_field_radius
	
	Events.player_health_changed.emit(0)
	Events.experience_received.emit()


func _process(delta):
	_process_movement(delta)
	
	var mouse_position = get_global_mouse_position()
	var angle = rad_to_deg(global_position.angle_to_point(mouse_position))
	
	$Player/TargetPoint.position = (mouse_position - global_position).normalized() * 50
	
	# quadrants
	if angle >= -22.5 and angle <= 22.5:
		$Player/AnimatedSprite2D.flip_h = true
		$Player/AnimatedSprite2D.flip_v = false
		$Player/AnimatedSprite2D.play("walk_right")
	if angle >= 22.5 and angle <= 67.5:
		$Player/AnimatedSprite2D.flip_h = true
		$Player/AnimatedSprite2D.flip_v = false
		$Player/AnimatedSprite2D.play("walk_diag_down")
	if angle >= 67.5 and angle <= 112.5:
		$Player/AnimatedSprite2D.flip_h = true
		$Player/AnimatedSprite2D.flip_v = false
		$Player/AnimatedSprite2D.play("walk_down")
	if angle >= 112.5 and angle <= 157.5:
		$Player/AnimatedSprite2D.flip_h = false
		$Player/AnimatedSprite2D.flip_v = false
		$Player/AnimatedSprite2D.play("walk_diag_down")		
	if angle >= 157.5 or angle <= -157.5:
		$Player/AnimatedSprite2D.flip_h = false		
		$Player/AnimatedSprite2D.flip_v = false
		$Player/AnimatedSprite2D.play("walk_right")
	if angle >= -157.5 and angle <= -112.5:
		$Player/AnimatedSprite2D.flip_h = false
		$Player/AnimatedSprite2D.flip_v = false
		$Player/AnimatedSprite2D.play("walk_diag_up")
	if angle >= -112.5 and angle <= -67.5:
		$Player/AnimatedSprite2D.flip_h = true
		$Player/AnimatedSprite2D.flip_v = false
		$Player/AnimatedSprite2D.play("walk_down")
	if angle >= -67.5 and angle <= -22.5:
		$Player/AnimatedSprite2D.flip_h = true
		$Player/AnimatedSprite2D.flip_v = false
		$Player/AnimatedSprite2D.play("walk_diag_up")


func _process_movement(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.length() == 0:
		$Player/AnimatedSprite2D.play("default")

	# normalize the direction vector so you can't move faster in the diagonal
	# than you can in just the horizontal/vertical
	var calculated_move_speed = CharacterService.calc_move_speed(self)
	
	position += direction.normalized() * calculated_move_speed * delta


func _handle_collision(collider: Node2D):
	if is_dead:
		return
		
	var collider_parent = collider.get_parent()
	
	if collider is Item:
		collider.on_pickup()
	if collider_parent is Enemy:
		take_damage(collider_parent.attack.total_value())


func take_damage(attack_damage: int):
	if is_damagable:
		is_damagable = false
		_flash(Color.RED)
		CharacterService.take_damage(self, attack_damage)
		await get_tree().create_timer(hit_invincibility_time).timeout
		is_damagable = true
	
	if is_dead:
		GameManager.game_over()
			

func _on_experience_received():
	_flash()


func _on_item_picked_up(item):
	call_deferred("add_child", item)


func _on_field_body_entered(body):
	if body != self and body is Item:
		(body as Item).seek()
		

func _flash(color: Color = Color.WHITE):
	ShaderEffects.flash($Player/AnimatedSprite2D.material, true, color)
	await get_tree().create_timer(0.1).timeout
	ShaderEffects.flash($Player/AnimatedSprite2D.material, false, color)
	

func _on_claw_body_entered(body: Node2D):
	var parent_node = body.get_parent()
	if parent_node is Enemy:
		# calc damage, do damage, is enemy dead, what do they drop
		parent_node.take_damage(attack.total_value())
		

func _on_health_changed(value: int):
	if value > 0:
		var popup = Pooling.get_from_pool(Pooling.PoolType.POPUP, func(): return number_popup_template.instantiate()) as NumberPopup
		SceneManager.current_scene.popup_container.add_child(popup)
		popup.health(str(value), global_position, 0, 0)
