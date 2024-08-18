class_name Placeable
extends Node3D
## Base class > Extend!


func _ready() -> void:
	pass # Replace with function body.


func _on_mouse_click_detector_mouse_clicked(button_index: int, event_position: Vector3) -> void:
	#TODO: interaction menu
	if button_index == MOUSE_BUTTON_MIDDLE:
		queue_free()
