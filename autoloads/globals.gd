extends Node
## Global data


var score: int = 0


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
