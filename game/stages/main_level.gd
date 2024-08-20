extends Node3D


func _ready() -> void:
	%BaseScene.hide()
	
	Dialogic.timeline_ended.connect(func(): get_tree().paused = false)
	
	Dialogic.start("res://story/timeline.dtl")
	get_tree().paused = true
	Dialogic.paused = false
	
	await Dialogic.timeline_ended
	
	Dialogic.start("res://story/Tutorial.dtl")
	get_tree().paused = true
	Dialogic.paused = false
	
	Events.module_placed.connect(on_first_module_placed, CONNECT_ONE_SHOT)


func _on_collectible_collected() -> void:
	Dialogic.start("res://story/Tutorial2.dtl")
	get_tree().paused = true
	Dialogic.paused = false


func on_first_module_placed(module: Placeable, data: UnitData) -> void:
	Dialogic.start("res://story/Tutorial3.dtl")
	get_tree().paused = true
	Dialogic.paused = false
	
	await Dialogic.timeline_ended
	
	%BaseScene.show()
