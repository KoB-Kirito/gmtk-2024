extends MeshInstance3D


@export var player: Node3D
@export var follow_height: float = 0.0  # Height at which the water should follow


func _ready():
	assert(player, "Please set the ship node path in the inspector")


func _physics_process(_delta):
	if player:
		var ship_position = player.global_transform.origin
		global_transform.origin = Vector3(ship_position.x, follow_height, ship_position.z)
