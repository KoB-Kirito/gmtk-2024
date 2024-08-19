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
var nextModuleID : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.playerManager = self
	
#region Example for nomi
	
	Events.module_placed.connect(on_module_placed)
	Events.more_Worker.connect(on_module_placed)
	Events.less_Worker.connect(on_module_placed)

func on_module_placed(module: Placeable, data: UnitData) -> void:
	print("module placed: ", data.name)
	
	data.module_ID = nextModuleID
	nextModuleID += 1
	
	var ui_module: Control # will result in your own object creation I guess
	
	res_materials -= data.materials
	res_money -= data.money
	
	module.tree_exited.connect(on_module_removed.bind(ui_module))


func on_module_removed(ui_module: Control) -> void:
	print("module exited")
	
	pass
	# do stuff with the connected ui_module
	
func on_moreWorker(ID : int) -> void:
	
	## Go through all in array, check ID and change
	
	pass

func on_lessWorker(ID : int) -> void:
	
	pass
#endregion


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
	
func canBuid() -> bool:
	
	#addModuleToList
	#giveIDtoModule
	return true;
