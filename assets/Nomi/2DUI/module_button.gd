extends Control


var myData : UnitData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func updateUI() -> void:
	
	print("Bin am tryharden! im module button")
	$ModuleButton/VBoxContainer/HBoxContainer/ActivityTag3.text = str(myData.people) + "/" + str(myData.peopleMax)
	
	if(myData.people >= myData.peopleNeed):
		$ModuleButton/VBoxContainer/HBoxContainer/ActivityTag.text = "Active"
	else:
		$ModuleButton/VBoxContainer/HBoxContainer/ActivityTag.text = "Inactive"
	
	if(myData.isEnergized):
		$ModuleButton/VBoxContainer/HBoxContainer2/ActivityTag4.text = "Energy"
	else:
		$ModuleButton/VBoxContainer/HBoxContainer2/ActivityTag4.text = "No Energy"
	pass
		
func _on_plus_button_button_up() -> void:
	print("Bin am tryharden! + button")
	Events.more_Worker.emit(myData.module_ID)
	pass # Replace with function body.


func _on_minus_button_2_button_up() -> void:
	print("Bin am tryharden! - button")
	Events.less_Worker.emit(myData.module_ID)
	pass # Replace with function body.


func _on_button_energy_button_up() -> void:
	myData.isEnergized != myData.isEnergized
	
	pass # Replace with function body.
