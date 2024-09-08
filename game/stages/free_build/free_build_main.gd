extends Node3D


const MIN_CHUNKS_FOR_READY = 40

@export var fade_in_data: TransitionDataIn


func _ready() -> void:
	%Robot.start_autowalk(10.0, 0.00001)
	%Robot.start_autocam(0.005)


func _on_chunks_child_order_changed() -> void:
	if %Chunks.get_child_count() > MIN_CHUNKS_FOR_READY:
		%Chunks.child_order_changed.disconnect(_on_chunks_child_order_changed)
		SceneTransition.fade_in(fade_in_data)
