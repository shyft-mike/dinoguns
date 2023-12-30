class_name Slot
extends Control

enum SlotType {WEAPON,ARMOR,AMULET}

@export var active: bool = true
@export var icon: Texture2D
@export var slot_type: SlotType
@export var item: SlottableItem
