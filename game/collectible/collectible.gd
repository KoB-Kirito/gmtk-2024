extends RigidBody3D


@export var item: InventoryItem


func _on_collect_area_body_entered(body: Node3D) -> void:
	if body is Player:
		Globals.inventory.append(item)
		#TODO: sfx, audio
		print(item.amount, " x ", item.unit_data.name, " collected!")
		queue_free()
