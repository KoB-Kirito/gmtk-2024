class_name UnitData
extends Resource


@export_file("*.tscn") var path: String
@export var name: String
@export_multiline var tooltip: String

@export var occupied_space: Vector3

@export var texture: Texture2D
@export var texture_hover: Texture2D
@export var texture_disabled: Texture2D
