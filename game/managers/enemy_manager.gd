class_name SpawnManager
extends Node
## Manages entity spawning


## Root node of spawn location nodes. Can move with the player
@export var locations_root: Node3D


@export_category("Enemies")
## Node to spawn enemies under. Should have no children
@export var enemies_root: Node3D
## Enemies to spawn. Scene must extend Enemy
@export_file("*.tscn") var enemie_scene_paths: Array[String]

@export_group("Settings")
## Maximum amount of enemies that can be alive
@export var max_enemies: int = 3

@export_group("Spawn Interval Range (seconds)")
@export var enemy_interval_min: float = 10.0
@export var enemy_interval_max: float = 20.0


@export_category("Collectibles")
## Node to spawn enemies under. Should have no children
@export var collectibles_root: Node3D
## Collectible scene path
@export_file("*.tscn") var collectible_scene_path: String

@export_group("Settings")
## Maximum amount of enemies that can be alive
@export var max_collectibles: int = 3

@export_group("Spawn Interval Range (seconds)")
@export var collectible_interval_min: float = 10.0
@export var collectible_interval_max: float = 20.0


var enemy_timer: Timer
var collectible_timer: Timer
var spawn_locations: Array[Node3D]


func _ready() -> void:
	# setup timers
	enemy_timer = Timer.new()
	enemy_timer.autostart = false
	enemy_timer.one_shot = true
	enemy_timer.timeout.connect(on_enemy_timer_timeout)
	add_child(enemy_timer)
	
	collectible_timer = Timer.new()
	collectible_timer.autostart = false
	collectible_timer.one_shot = true
	collectible_timer.timeout.connect(on_collectible_timer_timeout)
	add_child(collectible_timer)
	
	# cache location nodes
	for node in locations_root.get_children():
		if node is Node3D:
			spawn_locations.append(node)
	assert(spawn_locations, "No spawn locations found. Locations Root must have Node3D as children")


func on_enemy_timer_timeout() -> void:
	if enemies_root.get_child_count() < max_enemies:
		# load scene
		var enemy_scene: PackedScene = load(enemie_scene_paths.pick_random())
		
		# spawn enemy
		var enemy: Node3D = enemy_scene.instantiate()
		enemies_root.add_child(enemy)
		
		# set position
		enemy.global_position = spawn_locations.pick_random().global_position
	
	# restart timer
	enemy_timer.start(randf_range(enemy_interval_min, enemy_interval_max))


func on_collectible_timer_timeout() -> void:
	if collectibles_root.get_child_count() < max_collectibles:
		# load scene
		var collectible_scene: PackedScene = load(collectible_scene_path)
		
		# spawn enemy
		var collectible: Node3D = collectible_scene.instantiate()
		collectibles_root.add_child(collectible)
		
		# set position
		collectible.global_position = spawn_locations.pick_random().global_position
	
	# restart timer
	collectible_timer.start(randf_range(collectible_interval_min, collectible_interval_max))


## Starts enemies spawning. First enemy will spawn after the provided amount in seconds
func start_enemy_spawning(after: float) -> void:
	enemy_timer.start(after)


## Stops spawning enemies
func stop_enemy_spawning() -> void:
	enemy_timer.stop()


## Starts collectible spawning. First enemy will spawn after the provided amount in seconds
func start_collectible_spawning(after: float) -> void:
	collectible_timer.start(after)


## Stops spawning collectible
func stop_collectible_spawning() -> void:
	collectible_timer.stop()
