extends Control

var player : player_manager 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = $"../Player_Manager_1"
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func updateUI() -> void:
	
