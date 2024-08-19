extends Node3D


@export var test_inventory: Array[InventoryItem]


func _ready() -> void:
	#TEST
	# give all units
	for unit in Database.placeables:
		var item = InventoryItem.new()
		item.unit_data = unit
		Globals.inventory.append(item)
	
	# give start resources
	%player_manager.res_materials = 1000
	%player_manager.res_money = 1000
	Globals.playerManager = %player_manager
	
	
#region Example for nomi
	
	Events.module_placed.connect(on_module_placed)


func on_module_placed(module: Placeable, data: UnitData) -> void:
	print("module placed: ", data.name)
	
	var ui_module: Control # will result in your own object creation I guess
	
	module.tree_exited.connect(on_module_removed.bind(ui_module))


func on_module_removed(ui_module: Control) -> void:
	print("module exited")
	
	# do stuff with the connected ui_module
#endregion
