extends Node3D


@export var test_inventory: Array[InventoryItem]


func _ready() -> void:
	#TEST
	# give all units
	for unit in Database.placeables:
		var item = InventoryItem.new()
		item.unit_data = unit
		Globals.inventory.append(item)
