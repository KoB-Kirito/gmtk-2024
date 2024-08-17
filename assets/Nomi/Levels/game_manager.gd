extends Node3D


enum ENUM_GameState{main_menu, world, ui_menue}

var GameState : ENUM_GameState

var gameTime_seconds : float = 0

@export var player: Array[player_manager] 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameState = ENUM_GameState.world
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Check Current GameState
	if(GameState == ENUM_GameState.world):
		gameTime_seconds += delta
		
		for obj in player:
			obj.ressourcePerTick()
		
		
		
	
	
	
	pass
