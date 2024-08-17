#class_name BuildingSlot
extends Node3D
## Slot on which placeables can be build


@export var slot_type: Globals.SlotType
#@export var slot_orientation: Globals.SlotOrientation = Globals.SlotOrientation.UP

const UNIT_PANEL = preload("res://game/ui/unit_panel.tscn")


func _on_mouse_click_detector_mouse_clicked(button_index: int, event_position: Vector3) -> void:
	match button_index:
		MOUSE_BUTTON_LEFT:
			# build new unit
			var screen_position := get_viewport().get_camera_3d().unproject_position(event_position)
			
			var unit_panel := UNIT_PANEL.instantiate()
			unit_panel.setup(slot_type, get_slot_orientation())
			add_child(unit_panel)
			unit_panel.set_panel_position(screen_position)
			
			
			var unit = await unit_panel.unit_selected
			
			print_debug(unit)
			
			unit_panel.queue_free()
			
			if unit:
				build(unit)
		
		MOUSE_BUTTON_MIDDLE:
			remove()
		
		MOUSE_BUTTON_RIGHT:
			pass


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


func get_slot_orientation() -> Globals.SlotOrientation:
	if global_rotation_degrees.x > 45.0 or global_rotation_degrees.x < -45.0 or \
			global_rotation_degrees.z > 45.0 or global_rotation_degrees.z < -45.0:
		return Globals.SlotOrientation.SIDEWAYS
		
	else:
		return Globals.SlotOrientation.UP


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
