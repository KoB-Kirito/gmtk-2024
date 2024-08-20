class_name BuildingSlot
extends Node3D
## Base class > Extend!
## Slot on which placeables can be build


@export var slot_type: Globals.SlotType

const UNIT_PANEL = preload("res://game/ui/unit_panel.tscn")

@onready var collision_check_shape: BoxShape3D = %CollisionCheckerShape.shape


func _ready() -> void:
	%Hover.hide()


func _on_mouse_click_detector_mouse_clicked(button_index: int, event_position: Vector3) -> void:
	match button_index:
		MOUSE_BUTTON_LEFT:
			# build new unit
			var screen_position := get_viewport().get_camera_3d().unproject_position(event_position)
			
			var unit_panel := UNIT_PANEL.instantiate()
			unit_panel.setup(self)
			add_child(unit_panel)
			unit_panel.set_panel_position(screen_position)
			
			var unit: UnitData = await unit_panel.unit_selected
			
			unit_panel.queue_free()
			
			if unit:
				print("Picked unit: ", unit.name)
				build(unit)
				
			else:
				print("UI cancelled")
		
		MOUSE_BUTTON_MIDDLE:
			remove()
		
		MOUSE_BUTTON_RIGHT:
			pass


func build(unit_data: UnitData) -> void:
	# load object
	var placeable_scene: PackedScene = load(unit_data.path)
	var placeable: Placeable = placeable_scene.instantiate()
	
	# place object
	add_sibling(placeable, true)
	placeable.global_transform = global_transform
	print("rotating ", unit_data.rotation)
	placeable.rotate_object_local(Vector3.UP, unit_data.rotation)
	
	# tell nomi
	Events.module_placed.emit(placeable, unit_data)
	
	
	# replaced with physics proccess checking
	## disable until placeable is removed
	#placeable.tree_exited.connect(enable, CONNECT_ONE_SHOT)
	#disable()


func get_slot_orientation() -> Globals.SlotOrientation:
	if global_rotation_degrees.x > 45.0 or global_rotation_degrees.x < -45.0 or \
			global_rotation_degrees.z > 45.0 or global_rotation_degrees.z < -45.0:
		return Globals.SlotOrientation.SIDEWAYS
		
	else:
		return Globals.SlotOrientation.UP


func _physics_process(delta: float) -> void:
	if %Visual.visible:
		# check if area is blocked
		for area: Area3D in %BuildArea.get_overlapping_areas():
			if area is OccupationArea:
				# building space is blocked
				disable()
		
	else:
		# check if area is free
		for area: Area3D in %BuildArea.get_overlapping_areas():
			if area is OccupationArea:
				# building space is blocked
				return
		
		enable()


func is_area_free(area_size: Vector3) -> bool:
	# set the check area
	collision_check_shape.size = area_size - Vector3(0.1, 0.2, 0.1)
	%CollisionCheckerShape.position.y = area_size.y / 2.0 + 0.1
	
	#DEBUG
	#%CollisionChecker.force_update_transform() #TEST
	#%CollisionCheckerShape.force_update_transform()
	#HACK: wait a frame to let physic update
	await get_tree().physics_frame
	
	print(%CollisionChecker.get_overlapping_areas())
	
	# check
	for area: Area3D in %CollisionChecker.get_overlapping_areas():
		if area is OccupationArea:
			return false
	
	# nothing blocks the area
	return true


func disable() -> void:
	%Visual.hide()
	%MouseClickDetector.disable()


func enable() -> void:
	%Visual.show()
	%MouseClickDetector.enable()


func remove() -> void:
	if owner == null or owner is not Placeable:
		printerr("Can't remove build slot, no owner")
		return
	
	#TODO: fsx, sound
	owner.queue_free()


func _on_mouse_click_detector_mouse_entered() -> void:
	%Hover.show()


func _on_mouse_click_detector_mouse_exited() -> void:
	%Hover.hide()
