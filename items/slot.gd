class_name Slot
extends Control

enum SlotSize {SMALL,MEDIUM,LARGE,NONE}
enum SlotType {ARM,BACK,CHEST,NECK}

@export var active: bool = true
@export var icon: Texture2D
@export var slot_size: SlotSize
@export var slot_type: SlotType
@export var item: SlottableItem
