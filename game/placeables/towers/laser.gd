#class_name Laser
extends Placeable
## Pew pew


func _ready() -> void:
	pass # Replace with function body.


func _on_mouse_click_detector_mouse_clicked(button_index: int, mouse_postition: Vector3) -> void:
	if button_index == MOUSE_BUTTON_MIDDLE:
		remove()


func remove() -> void:
	#TODO: sfx, sound
	queue_free()
