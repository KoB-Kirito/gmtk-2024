class_name Enemy
extends CharacterBody3D


@export var heli: bool = false

const SPEED = 20.0
const MIN_DISTANCE = 1000.0

var player: Player


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not heli and not is_on_floor():
		velocity += get_gravity() * delta
	
	
	if not player:
		return
	
	
	look_at(player.global_position)
	
	
	if global_position.distance_squared_to(player.global_position) > MIN_DISTANCE:
		# far away
		var direction := global_position.direction_to(player.global_position)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		# near player
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
