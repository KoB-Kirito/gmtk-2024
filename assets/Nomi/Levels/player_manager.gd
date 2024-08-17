extends Node3D
class_name player_manager

#Ressources
var res_livingRoom : int = 120

var res_people : int
var res_people_employed : int = 0
var res_people_unemployed : int = 120

var res_energy_produced : int = 20
var res_energy_used : int = 0

var res_materials : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func ressourcePerTick() -> void:
	
	pass
