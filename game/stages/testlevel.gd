extends Node3D


@export var test_inventory: Array[InventoryItem]


func _ready() -> void:
	Globals.inventory = test_inventory
