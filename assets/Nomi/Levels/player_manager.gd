extends Node3D
class_name player_manager

#Ressources
var res_livingRoom : int = 160

var res_people : int
var res_people_employed : int = 0
var res_people_unemployed : int = 120
var gatheringPeople : int = 0

var res_energy_produced : int = 20
var res_energy_used : int = 0

var res_food_produced : int = 200
var res_food_used : int = 0

var res_materials : int = 0
var res_money : int = 0

@export var modules : Array[modules_base]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	res_people
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func ressourcePerTick() -> void:
	
		
	#receive 1 Person per 5 
	if(res_livingRoom > res_people && res_food_produced > res_people):
		if(gatheringPeople >= 5 ):
			res_people += 1
			gatheringPeople = 0
		else:
			gatheringPeople += 1
	else:
		gatheringPeople = 0
	
	
	%UI_Manager.updateUI()
	pass
