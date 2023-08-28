extends CharacterBody2D
class_name Player

@export var rotation_speed: int = 20

var _character: PlayerCharacter = null


func _ready():
	Events.character_selected.connect(_on_character_selected)
	Events.experience_received.connect(_on_experience_received)
	

func _process(delta):
	var mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle() * rotation_speed * delta
	
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	# normalize the direction vector so you can't move faster in the diagonal
	# than you can in just the horizontal/vertical
	var move_speed = _character.stats.calc_move_speed(State.standard_move_speed)
	var collision = move_and_collide(direction.normalized() * move_speed * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider is Item:
			collider.on_pickup()
	

func _draw():
	draw_circle(Vector2(0,0), 16, Color.WHITE)
	
	
func _on_character_selected(character: PlayerCharacter):
	_character = character
	

func _on_experience_received(value: int):
	print_debug("_on_experience_received - %d" % value)
	_character.add_experience(value)


func _on_field_body_entered(body):
	if body != self and body is Item:
		(body as Item).player_to_move_to = self
