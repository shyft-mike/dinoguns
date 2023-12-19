extends Player

# Abilities
var raptor_slash: RaptorSlash


func _ready():
	setup()
	

func setup():
	super.setup()

#	raptor_slash = load_ability("raptor_slash")


func _process(delta):
	if Input.is_action_pressed("attack"):
		var spawn_location = main_ability_marker.position
		
		if not animated_sprite.flip_h:
			spawn_location *= Vector2(-1.0, 1.0)
			
#		raptor_slash.execute(to_global(spawn_location), flipped)
		
