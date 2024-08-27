extends Node3D
class_name player_manager

#Ressources
var res_livingRoom : int = 50

var res_people : int = 20
var res_people_employed : int = 0
var res_people_unemployed : int = 30
var gatheringPeople : int = 0 #counter to get new people after x

var res_energy_produced : int = 0
var res_energy_used : int = 0

var res_food_produced : int = 30
var res_food_used : int = 0

var res_materials : int = 0
var res_money : int = 0

@export var modules : Array[UnitData]
var nextModuleID : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.playerManager = self
	
#region Example for nomi
	
	Events.module_placed.connect(on_module_placed)
	Events.more_Worker.connect(on_moreWorker)
	Events.less_Worker.connect(on_lessWorker)

func on_module_placed(module: Placeable, data: UnitData) -> void:
	print("module placed: ", data.name)

	var myData = data.duplicate()

	modules.append(myData)
	Globals.uiManager.initializeModuleUI(myData)
	
	
	myData.module_ID = nextModuleID
	nextModuleID += 1
	
	var ui_module: Control # will result in your own object creation I guess
	
	res_materials -= myData.materials
	res_money -= myData.money
	
	module.tree_exited.connect(on_module_removed.bind(ui_module))
	


func on_module_removed(ui_module: Control) -> void:
	print("module exited")
	
	pass
	# do stuff with the connected ui_module
	
func on_moreWorker(ID : int) -> void:
	print("Bin am tryharden! more worker suche jetzt mit ID" + str(ID))
	for module in modules:
		if(module.module_ID == ID):
			print("Bin am tryharden! gefunden und geaddet")
			if(module.people < module.peopleMax):
				module.people += 1
				
			#Check Workforce
			if(module.people > module.peopleNeed):
				module.isActive = true
				
			else:
				pass
		else:
			pass
	## Go through all in array, check ID and change
	
	Globals.uiManager.updateUI()
	Globals.uiManager.updateModuleUI()
	
	pass

func on_lessWorker(ID : int) -> void:
	print("Bin am tryharden! less worker")
	for module in modules:
		if(module.module_ID == ID):
			if(module.people > 0):
				module.people -= 1
				
			#Check Workforce
			if(module.people < module.peopleNeed):
				module.isActive = false
			else:
				pass
		else:
			pass
			
	Globals.uiManager.updateUI()
	pass
#endregion

func exectueAtTick() -> void:
	
	print( "atTick wird ausgeführt")
	res_livingRoom = 50
	res_food_produced = 30
	
	res_food_used = res_people
	res_energy_produced = 0
	res_energy_used = 0

	Globals.playerManager.res_money += 1
	Globals.playerManager.res_materials += 1
				
	
	
	
	for module in modules:
		print(module.name + "bin ein gefundenes module")
		
		if module.people >= module.peopleNeed:
			module.isActive = true
		
		
		if module.isActive:
			print(module.name + "bin ein aktives module")
			#1 Coin per Worker
			Globals.playerManager.res_money += module.people
			
			# Permanent Ressource
			res_livingRoom += module.prod_housing
			res_food_produced += module.prod_food
			res_energy_produced += module.prod_energy
			
			if module.isEnergized:
				print(module.name + "bin ein energized module")
				res_energy_used += module.energyNeed
				res_livingRoom += module.energized_prod_housing
				res_food_produced += module.energized_prod_food
				
			#Ticking Ressource
			if module.tickNeed < module.tickCount:
				module.tickCount += 1
				##Execute common
				pass
			else:
				module.tickCount = 0
				
				##Execute on Ticks
				Globals.playerManager.res_money += module.prod_money_perTick
				Globals.playerManager.res_materials += module.prod_materials_perTick
				
				if module.isEnergized:
					Globals.playerManager.res_money += module.energized_prod_money_perTick
					Globals.playerManager.res_materials += module.energized_prod_materials_perTick
		
	if(res_energy_used > res_energy_produced):
		for module in modules:
			module.isEnergized = false
		
		

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
	
func canBuid() -> bool:
	
	#addModuleToList
	#giveIDtoModule
	return true;
