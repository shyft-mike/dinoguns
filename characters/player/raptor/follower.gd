class_name Follower
extends RigidBody2D

@export var follow: Node2D
@export var follow_distance: int
@export var follow_speed: float

var tween: Tween


func _ready():
	$AnimatedSprite2D.play("walk")


func _process(delta):
	if not tween or not tween.is_running():
		start_tween()
	
	var direction_to_follow = global_position.direction_to(follow.global_position)
	var distance_to_follow = global_position.distance_to(follow.global_position)
	
	var dot_product = direction_to_follow.normalized().dot(follow.global_position.normalized())
	
	if dot_product <= 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false


func start_tween():
	if tween:
		tween.kill()
		
	tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", get_follow_position(), follow_speed)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.play()	


func get_follow_position():
	var direction_to_follow = follow.global_position - self.global_position
	direction_to_follow = direction_to_follow.normalized()
	return follow.global_position - direction_to_follow * follow_distance
