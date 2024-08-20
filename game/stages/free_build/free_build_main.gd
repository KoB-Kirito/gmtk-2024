extends Node3D


func _ready() -> void:
	%Robot.start_autowalk(10.0, 0.00001)
	%Robot.start_autocam(0.005)
