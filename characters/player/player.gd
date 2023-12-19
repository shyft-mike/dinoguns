class_name Player
extends Character

@onready var mutations: Node = $Mutations

@export var base_experience: int = 10

@export var is_selectable: bool
@export var is_visible: bool

var flipped: bool = false

var level: int = 0
var experience: int = 0
var total_experience: int = 0
var to_next_level: int = base_experience

var current_upgrades: Array[Upgrade] = []
var rage_stat_count: int = 0
var adaptation_stat_count: int = 0
var metabolism_stat_count: int = 0
var primal_stat_count: int = 0


# Abilities
var move: Move


func _init():
	Events.experience_received.connect(_on_experience_received)
	Events.item_picked_up.connect(_on_item_picked_up)
	Events.player_health_changed.connect(_on_health_changed)
	

func _ready():
	setup()
	

func setup():
	super.setup()
	
	level = 0
	experience = 0
	total_experience = 0
	to_next_level = base_experience
	current_upgrades = []
	rage_stat_count = 0
	adaptation_stat_count = 0
	metabolism_stat_count = 0
	primal_stat_count = 0
	
#	move = load_ability("move")
	
	Events.player_health_changed.emit(0)
	Events.experience_received.emit()


func _process_mouse(delta):
	var mouse_position = get_global_mouse_position()
	var player_mouse_direction = global_position.direction_to(mouse_position)
	
	# flip the entire node depending on where they should face
	# this flips collisions and mount points, etc
	if player_mouse_direction.x < 0:
		if not flipped:
			scale *= Vector2(-1, 1)
			flipped = true
	elif flipped:
		scale *= Vector2(-1, 1)
		flipped = false


func _process_input(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.length() == 0:
		animated_sprite.play("default")
	else:
		animated_sprite.play("walk_right")
		abilities.execute(Ability.AbilityType.MOVE, {direction=direction, delta=delta})
	

func _physics_process(delta):
	_process_mouse(delta)
	_process_input(delta)


func get_hit(attack_damage: int):
	if is_damagable:
		is_damagable = false
		flash(Color.RED)
		CharacterService.take_damage(self, DamageService.Damage.new(0, attack_damage))
		await get_tree().create_timer(hit_invincibility_time).timeout
		is_damagable = true
	
	if is_dead:
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


func _on_area_entered(area: Area2D):
	if is_dead:
		return

	var body = area.get_parent()

	if body is Item:
		body.pickup()
	if body is Enemy:
		get_hit(body.attack.total_value())


func _on_body_entered(body: Node2D):
	if is_dead:
		return

	if body is Item:
		body.pickup()
	if body is Enemy:
		get_hit(body.attack.total_value())
