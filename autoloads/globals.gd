extends Node
## Global data


var score: int = 0

var gameManager : GameManager 
var playerManager : player_manager
var uiManager : UI_Manager

# check if current mode is free build
var free_mode: bool

# inventory system
var inventory: Array[InventoryItem]

enum SlotType {
	SMALL,
	MEDIUM,
	LARGE,
}

enum SlotOrientation {
	ALL,
	UP,
	SIDEWAYS,
}
