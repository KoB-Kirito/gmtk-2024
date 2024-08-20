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
				# check resources
				var p_manager := Globals.playerManager
				assert(p_manager, "player manager is missing, set in Globals")
				
				if p_manager.res_materials >= unit.materials and p_manager.res_money >= unit.money:
					unit_button.unit_selected.connect(func(unit_data): unit_selected.emit(unit_data))
					
				else:
					unit_button.tooltip_text += "\n\n(Not enough resources)"
					disable_button(unit_button)
				
			else:
				# does not meet orientation requirement
				unit_button.tooltip_text += "\n\n(Can't be build in this orientation)"
				disable_button(unit_button)
			
		else:
			# does not meet slot size requirement
			unit_button.tooltip_text += "\n\n(Does not fit in this slot size)"
			disable_button(unit_button)


func disable_button(button: TextureButton) -> void:
	button.disabled = true
	button.modulate = Color.DIM_GRAY


## Sets the panel position to a screen position
func set_panel_position(screen_position: Vector2) -> void:
	%PanelContainer.position = screen_position


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		unit_selected.emit(null)
