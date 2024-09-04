extends Placeable


@export_range(0.1, 10.0, 0.1) var fire_rate: float = 0.25
@export_range(1.0, 30.0, 1.0) var damage: float = 2.0
@export var bullet_scene: PackedScene



var enemies_in_range: Array[Node3D] = []
var current_enemy: Enemy
var shooting_timer: Timer


func _ready() -> void:
	shooting_timer = Timer.new()
	shooting_timer.wait_time = fire_rate # Beispiel-Feuerrate, 1 Schuss pro Sekunde
	shooting_timer.timeout.connect(_shoot)
	add_child(shooting_timer)
	shooting_timer.start()
	


func _process(_delta: float) -> void:
	if current_enemy:
		look_at_2d(current_enemy.global_position)








func look_at_2d(target_position: Vector3) -> void:

	
	
	%Turret.look_at(target_position, %Turret.global_transform.basis.y)
	
	var euler_rotation = %Turret.rotation_degrees
	euler_rotation.x = clamp(euler_rotation.x, -30, 30)  # Begrenze Pitch auf -30 bis 30 Grad
	%Turret.rotation_degrees = euler_rotation
	%Turret.global_transform.basis

	
	%Base.rotation.y = %Turret.rotation.y
	



func _shoot() -> void:
	if current_enemy:
		
		
		
		var bullet: BulletCannon = bullet_scene.instantiate()
		
		var direction1 = -%Muzzle.global_transform.basis.z.normalized()
		bullet.direction = direction1
		bullet.damage = damage
		
		#print("Schieße Bullit in Richtung:", direction)
		get_parent().add_child(bullet)
		bullet.global_position = %Muzzle.global_position
		
		
		var bullet2: BulletCannon = bullet_scene.instantiate()
		
		var direction2 = -%Muzzle2.global_transform.basis.z.normalized()
		bullet2.direction = direction2
		bullet2.damage = damage
		
		#print("Schieße Bullit in Richtung:", direction)
		get_parent().add_child(bullet2)
		bullet2.global_position = %Muzzle2.global_position
		


func _on_patrolzone_body_entered(body: Node3D) -> void:
	if body is Enemy:
		#print_debug(body, "entered")
		if current_enemy == null:
			current_enemy = body
		enemies_in_range.append(body)
		#print(enemies_in_range.size())
		#print(body.global_position)
		look_at_2d(body.global_position)


func _on_patrolzone_body_exited(body: Node3D) -> void:
	if body is Enemy:
		#print(body, "exited")
		enemies_in_range.erase(body)
		if current_enemy == body:
			if enemies_in_range.size() > 0:
				current_enemy = enemies_in_range[0]
			else:
				current_enemy = null
		#print(enemies_in_range.size())
