extends Node3D


func _ready() -> void:
	#TODO: hide the UI during tutorial
	#%BaseScene.hide()
	
	#await get_tree().create_timer(0.2).timeout
	
	Dialogic.timeline_ended.connect(func(): get_tree().paused = false)
	
	#Dialogic.start("res://story/timeline.dtl")
	#get_tree().paused = true
	#Dialogic.paused = false
	#
	#await Dialogic.timeline_ended
	#
	#Dialogic.start("res://story/Tutorial.dtl")
	#get_tree().paused = true
	#Dialogic.paused = false
	
	Events.module_placed.connect(on_first_module_placed, CONNECT_ONE_SHOT)


func _on_collectible_collected(item: InventoryItem) -> void:
	Dialogic.start("res://story/Tutorial2.dtl")
	get_tree().paused = true
	Dialogic.paused = false
	
	# gift needed materials for first building
	Globals.playerManager.res_materials += item.unit_data.materials
	Globals.playerManager.res_money += item.unit_data.money


func on_first_module_placed(module: Placeable, data: UnitData) -> void:
	Dialogic.start("res://story/Tutorial3.dtl")
	get_tree().paused = true
	Dialogic.paused = false
	
	await Dialogic.timeline_ended
	
	#TODO
	#%BaseScene.show()
	
	%SpawnManager.start_collectible_spawning(1.0)
	%SpawnManager.start_enemy_spawning(10.0)
