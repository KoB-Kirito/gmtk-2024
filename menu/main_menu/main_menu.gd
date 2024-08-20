extends Control


## Scene that is loaded when start button is pressed
@export_file("*.tscn") var start_scene: String
@export_group("Transition")
@export var transition_duration_out: float = 1.0
@export var transition_duration_in: float = 1.0
@export var transition_color: Color = Color.BLACK
@export var next_song: AudioStream

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
	
	var transition_options := SceneTransition.Options.new(start_scene)
	transition_options.duration_out = transition_duration_out
	transition_options.duration_in = transition_duration_in
	transition_options.color = transition_color
	transition_options.new_bgm = next_song
	SceneTransition.change_scene(transition_options)


func _on_free_button_pressed() -> void:
	%Robot.stop_autowalk()
	%Robot.stop_autocam()
	hide()
	
	# skips resource checks on modules
	Globals.free_mode = true
	
	# add all modules
	Globals.inventory.append_array(Database.placeables)
	for module in Database.placeables:
		var item := InventoryItem.new()
		item.unit_data = module
		#TODO: infinite count
		Globals.inventory.append(item)


func _on_options_button_pressed() -> void:
	%OptionsMenu.show()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	#TODO: Does nothing on web
