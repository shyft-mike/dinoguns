class_name Item
extends RigidBody2D

@export var thumbnail_image: Texture2D
@export var state := ItemUtility.ItemState.STATIC : set = set_state
@export var friction: float = 1.2
@export var stop_threshold: float = 5.0
@export var can_seek: bool = true
@export var can_shine: bool = false

var launched_state: StateMachine = ItemLaunchedState.new()
var seeking_state: StateMachine = ItemSeekingState.new()
var static_state: StateMachine = ItemStaticState.new()
var current_state: StateMachine


func _ready():
	if can_shine:
		$AnimatedSprite2D.play("shine")

	gravity_scale = 0
	current_state = static_state
	current_state.enter_state(self)


func _process(delta):
	current_state.process_movement(self, delta)


func _physics_process(delta):
	current_state.process_physics(self, delta)


func pickup():
	assert(false, "pickup() not defined")


func set_state(value: ItemUtility.ItemState):
	if state == value:
		return

	current_state.exit_state(self)

	match value:
		ItemUtility.ItemState.LAUNCHED:
			current_state = launched_state
		ItemUtility.ItemState.SEEKING:
			current_state = seeking_state
		ItemUtility.ItemState.STATIC:
			current_state = static_state

	current_state.enter_state(self)


func seek():
	if can_seek:
		state = ItemUtility.ItemState.SEEKING


func remove():
	state = ItemUtility.ItemState.STATIC
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)


func launch(direction: Vector2 = Vector2.ZERO):
	state = ItemUtility.ItemState.LAUNCHED

	if direction.length() == 0:
		direction = Vector2(randi_range(-100, 100),randi_range(-100, 100))

	linear_velocity = direction
