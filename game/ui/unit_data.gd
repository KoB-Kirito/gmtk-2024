class_name UnitData
extends Resource
## Defines placeables


## Path to scene
@export_file("*.tscn") var path: String

# ui data
@export var name: String
@export_multiline var description: String

@export var texture: Texture2D
@export var texture_hover: Texture2D
@export var texture_disabled: Texture2D

# requirements
@export var occupied_space: Vector3
@export var slot_type: Globals.SlotType
@export var slot_orientation: Globals.SlotOrientation

## Required material
@export var materials: int
## Required money
@export var money: int
## Required people
@export var people: int

# in-code
@export_storage var rotation: float = 0.0
