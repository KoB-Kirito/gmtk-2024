class_name UnitPanel
extends ColorRect


const UNIT_BUTTON = preload("res://game/ui/unit_button.tscn")


signal unit_selected(unit: UnitData)


func setup(slot: BuildingSlot) -> void:
	var slot_orientation = slot.get_slot_orientation()
	
	for item: InventoryItem in Globals.inventory:
		var unit := item.unit_data
		
		var unit_button = UNIT_BUTTON.instantiate()
		unit_button.setup(unit, slot)
		%GridContainer.add_child(unit_button)
		
		# check if unit can be placed in slot
		# only allow exact matching slot #TODO: allow all?
		#if slot.slot_type == unit.slot_type:
		# allow matching or larger slot
		if slot.slot_type >= unit.slot_type:
			# only allow matching orientation
			if unit.slot_orientation == Globals.SlotOrientation.ALL or slot_orientation == unit.slot_orientation:
				# debug
				if unit.occupied_space <= Vector3.ZERO:
					push_error("item has no occupied space set: ", unit.name)
				
				# check resources
				var p_manager := Globals.playerManager
				assert(p_manager, "player manager is missing, set in Globals")
				
				if p_manager.res_materials >= unit.materials and p_manager.res_money >= unit.money:
					unit_button.unit_selected.connect(func(unit_data): unit_selected.emit(unit_data))
					
				else:
					unit_button.tooltip_text += "\n\n(Not enough resources)"
					unit_button.disabled = true
				
				#TODO: space check not needed anymore with rotation preview
				# check if space is enough
				#if await slot.is_area_free(unit.occupied_space):
					## unit meets requirements for this slot
					#unit_button.pressed.connect(func(): unit_selected.emit(unit))
					#
				#else:
					## area does not have enough space
					#unit_button.tooltip_text += "\n\n(Not enough space available)"
					#unit_button.disabled = true
				
			else:
				# does not meet orientation requirement
				unit_button.tooltip_text += "\n\n(Can't be build in this orientation)"
				unit_button.disabled = true
			
		else:
			# does not meet slot size requirement
			unit_button.tooltip_text += "\n\n(Does not fit in this slot size)"
			unit_button.disabled = true


## Sets the panel position to a screen position
func set_panel_position(screen_position: Vector2) -> void:
	%PanelContainer.position = screen_position


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		unit_selected.emit(null)
