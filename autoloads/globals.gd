extends Node
## Global data


var score: int = 0

var gameManager : GameManager 
var playerManager : player_manager
var uiManager : UI_Manager


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
