#class_name Block1x1
extends Placeable


func _on_mouse_click_detector_mouse_clicked(button_index: int) -> void:
	#TEST
	if button_index == MOUSE_BUTTON_RIGHT:
		queue_free()
