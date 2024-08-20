class_name UnitData
extends Resource
## Defines placeables


## Name for this module
@export var name: String
## Path to scene
@export_file("*.tscn") var path: String
## Icon representing the module in the UI
@export var texture: Texture2D

@export_group("Description")
## Used in tooltip
@export_multiline var description: String

@export_group("Build Requirements")
## Minimum slot size
@export var slot_type: Globals.SlotType
## Allowed slot orientation
@export var slot_orientation: Globals.SlotOrientation
## Required material
@export var materials: int
## Required money
@export var money: int
## Required people
@export var people: int

# in-code
## asignedByPlayerManager
@export_storage var module_ID : int
## Preserves rotation from preview
@export_storage var rotation: float = 0.0
