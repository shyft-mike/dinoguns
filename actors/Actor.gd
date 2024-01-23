class_name Actor extends CharacterBody2D

@export var stat_manager: ActorStatManager
@export var number_popup_template: PackedScene = preload("res://ui/NumberPopup.tscn")

@onready var _controller_container: Node = $ControllerContainer
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _body: Node2D = $Body
@onready var _body_sprite: Sprite2D = $Body/BodySprite
@onready var _hurt_box: HurtBox = $Body/HurtBox
@onready var _popup_marker: Marker2D = $Body/PopupMarker
@onready var _debuff_manager: DebuffManager = $Body/DebuffManager

var _ability_container: Node2D
var _controller: ActorController

var _facing: Vector2 = Vector2.RIGHT
var _flipped: bool = false

var _input_direction: Vector2


func setup():
	stat_manager.setup()

	_ability_container = get_node_or_null("AbilityContainer")


func set_controller(controller: ActorController) -> void:
	clear_controller()

	_controller = controller
	_controller_container.add_child(controller)


func clear_controller() -> void:
	for child_controller in _controller_container.get_children():
		child_controller.queue_free()


func move(direction: Vector2) -> void:
	if not direction.is_normalized():
		direction = direction.normalized()

	# flip the entire node depending on where they should face
	# this flips collisions and mount points, etc
	if direction.length() > 0:
		if direction.x < 0:
			if not _flipped:
				_body.scale.x *= -1
				_flipped = true
		elif direction.x > 0 and _flipped:
			_body.scale.x *= -1
			_flipped = false

	_input_direction = direction


func flash(color: Color = Color.WHITE):
	ShaderEffects.flash(_body_sprite.material, true, color)
	await get_tree().create_timer(0.1).timeout
	ShaderEffects.flash(_body_sprite.material, false, color)


func add_ability(ability: Ability) -> void:
	if _ability_container:
		_ability_container.call_deferred("add_child", ability)


func apply_frozen() -> void:
	_debuff_manager.is_frozen = true
	_body_sprite.modulate = Color.BLUE
	_animation_player.speed_scale *= 0.5


func _handle_movement():
	velocity = _input_direction * stat_manager.get_move_speed(self)

	if velocity.length() < 0.1:
		_animation_player.play("RESET")
	else:
		_animation_player.play("walk")

	move_and_slide()
