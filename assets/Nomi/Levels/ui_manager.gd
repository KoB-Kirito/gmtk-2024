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
	
	%Money_val.text = str( $"../Player_Manager_1".res_money)
	%Material_val.text = str($"../Player_Manager_1".res_materials)
	%Homes_val.text = str($"../Player_Manager_1".res_livingRoom)
	%People_val.text = str($"../Player_Manager_1".res_people)
	%Energy_val.text = str($"../Player_Manager_1".res_energy_produced)
	%Food_val.text = str($"../Player_Manager_1".res_food_produced)
	%Energy_cons_val.text = str($"../Player_Manager_1".res_energy_used)
	%Food_cons_val.text = str($"../Player_Manager_1".res_food_used)
	pass
	
	
