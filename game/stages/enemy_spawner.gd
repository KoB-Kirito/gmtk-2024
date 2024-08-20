extends Node3D

@export var parent_node: Node3D
@export var enemie_paths: Array[String]
@export var time_min: float = 10.0
@export var time_max: float = 30.0


func start() -> void:
	%Timer.start(randf_range(time_min, time_max))


func _on_timer_timeout() -> void:
	var enemy_scene: PackedScene = load(enemie_paths.pick_random())
	
	# spawn enemy
	var enemy: Node3D = enemy_scene.instantiate()
	parent_node.add_child(enemy)
	
	%Timer.start(randf_range(time_min, time_max))
