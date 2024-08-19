extends Node
## Global event bus


signal game_paused
signal game_unpaused


signal module_placed(module: Placeable, module_data: UnitData)

signal more_Worker(ID : int)

signal less_Worker(ID : int)
