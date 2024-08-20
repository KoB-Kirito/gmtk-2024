class_name Player
extends CharacterBody3D


const SPEED = 50.0
const ROTATION_SPEED = 0.01
const JUMP_VELOCITY = 14.5
const GRAVITY_MULTIPLYER = 2.0

var _autowalk: bool
var _autowalk_speed: float
var _autowalk_rotation: float

var _autocam: bool
var _autocam_speed: float


func _ready() -> void:
	%SpringArm3D.add_excluded_object(self)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_MULTIPLYER
	
	
	if _autocam:
		%CameraPivotY.rotate_object_local(Vector3.UP, _autocam_speed)
	
	if _autowalk:
		velocity.z = -_autowalk_speed
		rotate_y(_autowalk_rotation)
		move_and_slide()
		%AnimationPlayer.play("Run")
		return # player can't control robot while autowalk is enabled
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("strafe_left", "strafe_right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	# rotation
	if Input.is_action_pressed("turn_left"):
		rotate_y(ROTATION_SPEED)
	
	if Input.is_action_pressed("turn_right"):
		rotate_y(-ROTATION_SPEED)
	
	move_and_slide()
	
	# animation
	if velocity.is_zero_approx():
		%AnimationPlayer.play("0TPose")
		
	else:
		%AnimationPlayer.play("Run")


@export var camera_sensitivity = 0.5

# camera
func _unhandled_input(event: InputEvent) -> void:
	if _autowalk:
		return
	
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		return
	
	# camera movement via mouse
	if event is InputEventMouseMotion:
		%CameraPivotY.rotate_object_local(Vector3.UP, deg_to_rad(-event.relative.x * camera_sensitivity))
		%CameraPivotX.rotate_object_local(Vector3.RIGHT, deg_to_rad(-event.relative.y * camera_sensitivity))
		%CameraPivotX.rotation.x = clamp(%CameraPivotX.rotation.x, deg_to_rad(-90), deg_to_rad(60))


# used for cutscenes etc
func start_autowalk(speed: float, walk_rotation: float = 0.0) -> void:
	_autowalk_speed = speed
	_autowalk_rotation = walk_rotation
	_autowalk = true

func stop_autowalk() -> void:
	_autowalk = false


func start_autocam(speed: float) -> void:
	_autocam_speed = speed
	_autocam = true

func stop_autocam() -> void:
	_autocam = false
