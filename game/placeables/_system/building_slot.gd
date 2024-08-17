#class_name BuildingSlot
extends Node3D
## Slot on which placeables can be build


func _on_mouse_click_detector_mouse_clicked(button_index: int) -> void:
	#TEST
	match button_index:
		MOUSE_BUTTON_LEFT:
			build("res://game/placeables/buildings/block_1x1.tscn")
		
		MOUSE_BUTTON_MIDDLE:
			build("res://game/placeables/towers/laser.tscn")
		
		MOUSE_BUTTON_RIGHT:
			remove()


func build(placeable_path: String) -> void:
	print("building")
	# load object
	var placeable_scene: PackedScene = load(placeable_path)
	var placeable: Placeable = placeable_scene.instantiate()
	
	# place object
	add_sibling(placeable, true)
	placeable.global_transform = global_transform
	
	# disable until placeable is removed
	placeable.tree_exited.connect(enable, CONNECT_ONE_SHOT)
	disable()


func disable() -> void:
	%Visual.hide()
	%ClickCollision.disabled = true


func enable() -> void:
	%Visual.show()
	%ClickCollision.disabled = false


func remove() -> void:
	if owner == null or owner is not Placeable:
		printerr("Can't remove build slot, no owner")
		return
	
	#TODO: fsx, sound
	owner.queue_free()
