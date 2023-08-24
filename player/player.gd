extends CharacterBody2D

enum DINO_DNA {RED, GREEN, BLUE, YELLOW}

@export var rotation_speed: int = 20
@export var move_speed: int = 40

var character: Character = null


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
	position += direction.normalized() * move_speed * Global.speed_multiplier * delta


func _draw():
	draw_circle(Vector2(0,0), 16, Color.WHITE)


func init(selected_character):
	character = selected_character
	
	move_speed = character.stats.speed.total_value()
