class_name UnitPanel
extends ColorRect


const UNIT_BUTTON = preload("res://game/ui/unit_button.tscn")


signal unit_selected(unit: String)


func setup(slot_type: Globals.SlotType, slot_orientation: Globals.SlotOrientation) -> void:
	for item: InventoryItem in Globals.inventory:
		var unit_button = UNIT_BUTTON.instantiate()
		unit_button.setup(item.unit_data)
		%GridContainer.add_child(unit_button)
		
		# check if unit can be placed in slot
		if slot_type == item.slot_type:
			if item.slot_orientation == Globals.SlotOrientation.ALL or slot_orientation == item.slot_orientation :
				# unit meets requirements for this slot
				unit_button.pressed.connect(func(): unit_selected.emit(item.unit_data.path))
				
			else:
				# does not meet orientation requirement
				unit_button.disabled = true
			
		else:
			# does not meet slot size requirement
			unit_button.disabled = true


## Sets the panel position to a screen position
func set_panel_position(screen_position: Vector2) -> void:
	%PanelContainer.position = screen_position


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		unit_selected.emit("")
