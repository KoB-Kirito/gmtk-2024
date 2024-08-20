extends Node3D
class_name GameManager


enum ENUM_GameState{main_menu, world, ui_menue}

var GameState : ENUM_GameState

var gameTime : float = 0
var gameTime_seconds : int = 0

@export var player: Array[player_manager] 

signal Tick_second

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Globals.gameManager = self
	GameState = ENUM_GameState.world
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Check Current GameState
	if(GameState == ENUM_GameState.world):
		
		
		gameTime += delta
		
		if(gameTime_seconds < floor(gameTime)):
			gameTime_seconds += 1
			#for obj in player: 
				##obj.ressourcePerTick() # done by signal
			Tick_second.emit()
		
		
		
	
	
	
	pass
	
