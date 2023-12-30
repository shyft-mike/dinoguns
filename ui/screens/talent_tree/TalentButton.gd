class_name TalentButton
extends TextureButton

@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/Label
@onready var line_2d: Line2D = $Line2D

@export var initial_line_color: Color = Color(0.23, 0.23, 0.23)
@export var connected_line_color: Color
@export var max_level: int = 3

var level: int:
	set(value):
		level = value
		label.text = str(level) + "/" + str(max_level)
		panel.show_behind_parent = (level != 0)
		line_2d.default_color = initial_line_color if level == 0 else connected_line_color


func _ready() -> void:
	var parent_talent = get_parent() as TalentButton
	if parent_talent:
		set_talent_disabled(true)
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(parent_talent.global_position + size/2)
	else:
		set_talent_disabled(false)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if disabled:
			return
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			level = min(level + 1, max_level)
			Events.talent_updated.emit(self)
		elif event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			level = max(level - 1, 0)
			Events.talent_updated.emit(self)


func set_talent_disabled(is_disabled: bool):
	disabled = is_disabled
	if is_disabled:
		level = 0
		self_modulate = Color.RED
	else:
		self_modulate = Color.WHITE


func disable_children():
	for child in get_children():
		if child is TalentButton:
			child.set_talent_disabled(true)
			child.disable_children()
