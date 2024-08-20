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

@export_group("Data")

var tickCount : int = 0
var tickNeed : int = 0
## HasPeopleToWork?
@export_storage var isActive : bool

## Produces Bonus Ressources?
@export_storage var isEnergized : bool

## Required energy while running
@export var energyNeed : int
@export var peopleNeed : int
@export var peopleMax : int

@export var ticks_every_x_seconds : int = 1
@export var energized_ticks_every_x_seconds : int = 1

@export var prod_materials_perTick : int = 0
@export var prod_money_perTick : int = 0

@export var prod_food : int = 0
@export var prod_energy : int = 0
@export var prod_housing : int = 0

@export var energized_prod_materials_perTick : int = 0
@export var energized_prod_money_perTick : int = 0

@export var energized_prod_food : int = 0
#@export var energized_prod_energy : int = 0
@export var energized_prod_housing : int = 0

# in-code
## asignedByPlayerManager
@export_storage var module_ID : int
@export_storage var myButton
## Preserves rotation from preview
@export_storage var rotation: float = 0.0
