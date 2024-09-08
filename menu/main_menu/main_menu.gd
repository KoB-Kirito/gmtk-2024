extends Control


## Scene that is loaded when start button is pressed
@export var arcade_transition: TransitionDataOut

@export_group("BGM")
@export var bgm: AudioStream
@export var volume_db: float = 0.0


func _ready() -> void:
	PauseMenu.enabled = false
	
	if bgm:
		Bgm.fade_to(bgm, volume_db, 0.0)


func _on_start_button_pressed() -> void:
	# start normal game
	PauseMenu.enable()
	
	SceneTransition.fade_out_change_scene(arcade_transition)


func _on_free_button_pressed() -> void:
	PauseMenu.enable()
	
	%Robot.stop_autowalk()
	%Robot.stop_autocam()
	
	# skips resource checks on modules
	Globals.free_mode = true
	
	# add all modules
	for module in Database.placeables:
		var item := InventoryItem.new()
		item.unit_data = module
		#TODO: infinite count
		Globals.inventory.append(item)
	
	# remove main menu
	queue_free()


func _on_options_button_pressed() -> void:
	%OptionsMenu.show()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	#TODO: Does nothing on web
