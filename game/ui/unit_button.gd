class_name UnitButton
extends TextureButton


const preview_shader = preload("res://game/placeables/preview_material.tres")

signal unit_selected(unit_data: UnitData, rotation: float)

var _slot: BuildingSlot
var _unit_data: UnitData

var module: Placeable
var applied_rotation: float

var hovered: bool

var module_area_is_free: bool = false:
	set(value):
		if value != module_area_is_free:
			module_area_is_free = value
			if module_area_is_free:
				RenderingServer.global_shader_parameter_set("preview_color", Color.GREEN)
			else:
				RenderingServer.global_shader_parameter_set("preview_color", Color.RED)



func setup(unit_data: UnitData, slot: BuildingSlot) -> void:
	_slot = slot
	_unit_data = unit_data
	
	#TODO: name
	tooltip_text = unit_data.name + "\n" + unit_data.description
	texture_normal = unit_data.texture
	texture_hover = unit_data.texture_hover
	texture_disabled = unit_data.texture_disabled


func _on_mouse_entered() -> void:
	if disabled:
		return
	
	hovered = true
	print("mouse entered")
	
	# highlight
	modulate = Color(2.0, 2.0, 2.0)
	
	# load object
	var placeable_scene: PackedScene = load(_unit_data.path)
	var placeable: Placeable = placeable_scene.instantiate()
	
	# place object
	_slot.add_sibling(placeable, true)
	placeable.global_transform = _slot.global_transform
	
	# override shader on all meshes
	for mesh: MeshInstance3D in placeable.find_children("*", "MeshInstance3D"):
		#mesh.set_surface_override_material(0, preview_shader)
		mesh.material_override = preview_shader
	
	#TODO: remove all csgs before export!
	for csg: CSGPrimitive3D in placeable.find_children("*", "CSGPrimitive3D"):
		#mesh.set_surface_override_material(0, preview_shader)
		csg.material_override = preview_shader
	
	
	module = placeable


func _on_mouse_exited() -> void:
	if disabled:
		return
	
	# highlight
	modulate = Color(1.0, 1.0, 1.0)
	
	hovered = false
	print("mouse exited")
	
	if module:
		module.queue_free()


func _on_pressed() -> void:
	if module_area_is_free:
		_unit_data.rotation = applied_rotation
		unit_selected.emit(_unit_data)
		
	else:
		unit_selected.emit(null)


func _input(event: InputEvent) -> void:
	if not hovered:
		return
	
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			print("wheel down")
			applied_rotation += PI/2.0
			#module.rotate_y(PI/2.0)
			module.rotate_object_local(Vector3.UP, PI/2)
			get_viewport().set_input_as_handled()
			
		elif mouse_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			print("wheel up")
			applied_rotation -= PI/2.0
			#module.rotate_y(-PI/2.0)
			module.rotate_object_local(Vector3.UP, -PI/2)
			get_viewport().set_input_as_handled()


func _physics_process(delta: float) -> void:
	if not hovered or not module:
		return
	
	# check collision and change preview color
	module_area_is_free = not module.is_colliding_with_occupied_area()
	#print(module_area_is_free)
