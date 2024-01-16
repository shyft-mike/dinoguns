class_name TalentButton
extends TextureButton

@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/Label
@onready var line_2d: Line2D = $Line2D

@export var talent: Talent
@export var initial_line_color: Color = Color(0.23, 0.23, 0.23)
@export var connected_line_color: Color


func _ready() -> void:
	var parent_talent = get_parent() as TalentButton
	if parent_talent:
		talent.set_disabled(true)
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(parent_talent.global_position + size/2)
	else:
		talent.set_disabled(false)


func _process(delta: float) -> void:
	if talent.is_disabled:
		disabled = true
		self_modulate = Color.RED
	else:
		disabled = false
		self_modulate = Color.WHITE


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if disabled:
			return
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			set_level(min(talent.level + 1, talent.max_level))
			Events.talent_updated.emit(self)
		elif event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			set_level(max(talent.level - 1, 0))
			Events.talent_updated.emit(self)


func set_level(value: int) -> void:
	talent.level = value
	label.text = str(talent.level) + "/" + str(talent.max_level)
	panel.show_behind_parent = (talent.level != 0)
	line_2d.default_color = initial_line_color if talent.level == 0 else connected_line_color


func disable_children():
	for child in get_children():
		if child is TalentButton:
			child.talent.set_disabled(true)
			child.disable_children()
