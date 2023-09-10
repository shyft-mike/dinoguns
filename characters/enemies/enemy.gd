extends CharacterBody2D
class_name Enemy


enum EnemyState {PERSUING,RETREATING}

var damage_popup_template := preload("res://interface/damage_popup.tscn")
var current_state: EnemyState = EnemyState.PERSUING
var last_sighting: Vector2
var character: EnemyCharacterSheet


func _ready():
	$AnimatedSprite2D.play($AnimatedSprite2D.animation)
	

func _physics_process(delta):
	var direction_to_player = global_position.direction_to(State.player.global_position)
	var distance_to_player = global_position.distance_to(State.player.global_position)
	
	var dot_product = direction_to_player.normalized().dot(State.player.global_position.normalized())
	
	if dot_product <= 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	match current_state:
		EnemyState.PERSUING:
			if distance_to_player > 50:
				velocity = direction_to_player * character.calc_move_speed(State.standard_move_speed)
			if distance_to_player <= 50:
				current_state = EnemyState.RETREATING
				last_sighting = State.player.global_position
				velocity = -direction_to_player * character.calc_move_speed(State.standard_move_speed) * 1.1
		
		EnemyState.RETREATING:
			$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
			velocity = -global_position.direction_to(last_sighting) * character.calc_move_speed(State.standard_move_speed) * 1.1
			if global_position.distance_to(last_sighting) > 300:
				current_state = EnemyState.PERSUING
		
	move_and_slide()
	

func take_damage(attack_damage: int):
	var damage_done = character.take_damage(attack_damage)
	
	_flash()
	_show_damage_popup(damage_done)
	
	if character.is_dead:
		_drop_items(character.drops)
		if is_inside_tree():
			get_parent().remove_child(self)


func _drop_items(drops: Array[ItemFactory.ItemType]):
	for drop in character.drops:
		var item_to_drop
		match drop:
			ItemFactory.ItemType.AMBER:
				item_to_drop = Pooling.get_from_pool(
					Pooling.PoolType.AMBER, 
					func(): return ItemFactory.generate_item(drop))				
			ItemFactory.ItemType.BIG_AMBER:
				item_to_drop = Pooling.get_from_pool(
					Pooling.PoolType.BIG_AMBER, 
					func(): return ItemFactory.generate_item(drop))
		item_to_drop.global_position = global_position
		get_parent().call_deferred("add_child", item_to_drop)
		item_to_drop.call_deferred("launch")
		

func _flash():
	ShaderEffects.flash($AnimatedSprite2D.material, true)
	await get_tree().create_timer(0.1).timeout
	ShaderEffects.flash($AnimatedSprite2D.material, false)
	
	
func _show_damage_popup(damage_done: int):
	var damage_popup = Pooling.get_from_pool(Pooling.PoolType.DAMAGE_POPUP, func(): return damage_popup_template.instantiate())
	get_parent().add_child(damage_popup)
	damage_popup.execute(str(damage_done), global_position, 0, 0)
	
