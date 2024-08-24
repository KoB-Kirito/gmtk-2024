extends RigidBody3D


signal collected(item: InventoryItem)


func _on_collect_area_area_entered(area: Area3D) -> void:
	if area.owner is Player:
		# random item
		var item := InventoryItem.new()
		item.unit_data = Database.placeables.pick_random()
		item.amount = 1
		
		# give item
		# check if already in inventory
		var item_found: bool = false
		for i: InventoryItem in Globals.inventory:
			if i.unit_data.name == item.unit_data.name:
				i.amount += 1
				item_found = true
				print(item.amount, " x ", item.unit_data.name, " collected! (now ", i.amount, ")")
				break
		
		# add new
		if not item_found:
			Globals.inventory.append(item)
			print(item.amount, " x ", item.unit_data.name, " collected! (new)")
		
		# remove collectible
		#TODO: sfx, audio
		collected.emit(item)
		queue_free()
