class_name NumberPopup
extends Node2D

@onready var label_container: Node2D = $LabelContainer
@onready var label: Label = $LabelContainer/HBoxContainer/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var icons: Control = $LabelContainer/HBoxContainer/Icons
@onready var fire_damage_icon: TextureRect = $LabelContainer/HBoxContainer/Icons/FireDamageIcon
@onready var ice_damage_icon: TextureRect = $LabelContainer/HBoxContainer/Icons/IceDamageIcon
@onready var heal_icon: TextureRect = $LabelContainer/HBoxContainer/Icons/HealIcon


func remove() -> void:
	for icon in icons.get_children():
		icon.hide()
	icons.hide()

	animation_player.stop()
	if is_instance_valid(self) and is_inside_tree():
		get_parent().remove_child(self)


func _execute(value: String, start_position: Vector2, height: float, spread: float, icon: TextureRect = null) -> void:
	if icon:
		icons.show()
		icon.show()

	label.text = value
	animation_player.play("swell")

	var tween = get_tree().create_tween()
	var end_position = Vector2(randf_range(-spread, spread), -height) + start_position
	var tween_length = animation_player.get_animation("swell").length

	tween.tween_property(label_container, "position", end_position, tween_length).from(start_position)


func damage(value: String, start_position: Vector2, height: float, spread: float, damage_type: DamageService.DamageType = 0) -> void:
	var icon
	label.modulate = Color.WHITE

	match damage_type:
		DamageService.DamageType.FIRE:
			icon = fire_damage_icon
			label.modulate = Color.RED
		DamageService.DamageType.ICE:
			icon = ice_damage_icon
			label.modulate = Color.SKY_BLUE

	_execute(value, start_position, height, spread, icon)


func health(value: String, start_position: Vector2, height: float, spread: float) -> void:
	label.modulate = Color.LAWN_GREEN
	_execute(value, start_position, height, spread, heal_icon)

