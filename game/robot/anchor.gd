extends Node3D


func _physics_process(delta: float) -> void:
	global_position = %Cylinder_004.global_position
	rotation.x = %Cylinder_004.rotation.x
	rotation.z = %Cylinder_004.rotation.z
