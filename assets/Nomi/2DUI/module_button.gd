extends Panel

var module_ID : int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_plus_button_button_up() -> void:
	Events.more_Worker.emit(module_ID)
	pass # Replace with function body.


func _on_minus_button_2_button_up() -> void:
	Events.less_Worker.emit(module_ID)
	pass # Replace with function body.
