extends Node3D

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
	pass
	#if current_enemy:
		#look_at_2d(current_enemy.global_position)












#func look_at_2d(target_position: Vector3) -> void:
	## Berechne die Richtung zum Ziel in globalen Koordinaten
	#var direction = (target_position - %Base.global_transform.origin).normalized()
#
	## Entferne die Komponente der Richtung entlang der lokalen Y-Achse
	#direction -= %Base.global_transform.basis.y * direction.dot(%Base.global_transform.basis.y)
#
	## Normalisiere die Richtung, um sicherzustellen, dass sie nur in der lokalen XZ-Ebene liegt
	#direction = direction.normalized()
#
	## Berechne den neuen Transform, der den Turm in Richtung des Ziels dreht
	#var new_basis = %Base.global_transform.basis
	#new_basis.z = -direction  # Vorwärtsrichtung (Z-Achse)
	#new_basis.x = new_basis.y.cross(new_basis.z).normalized()  # Rechtsrichtung (X-Achse)
	#new_basis.y = new_basis.z.cross(new_basis.x).normalized()  # Aufwärtsrichtung (Y-Achse)
#
	## Setze den neuen Transform auf den Turm
	#%Base.global_transform.basis = new_basis
	
	
	
	
	
	
	#%Base.look_at(target_position, %Base.global_transform.basis.y)
	
	#var euler_rotation = %TurretControl.rotation_degrees
	#euler_rotation.x = clamp(euler_rotation.x, -30, 30)  # Begrenze Pitch auf -30 bis 30 Grad
	#%TurretControl.rotation_degrees = euler_rotation
	#%TurretControl.global_transform.basis
#
	#
	#%Base.rotation.y = %TurretControl.rotation.y
	




func _shoot() -> void:
	if current_enemy:
		
		
		
		var bullet: BulletCannon = bullet_scene.instantiate()
		
		#var direction = (current_enemy.global_position - %Muzzle.global_transform.origin).normalized()
		#direction.z = 0  # Y-Achse ignorieren
		var direction_to_enemy = (current_enemy.global_position - %Muzzle.global_position).normalized()
		#var direction = -%Muzzle.global_transform.basis.z.normalized()
		bullet.direction = direction_to_enemy
		bullet.damage = damage
		
		#print("Schieße Bullit in Richtung:", direction)
		get_parent().add_child(bullet)
		bullet.global_position = %Muzzle.global_position
		
		
		


func _on_patrolzone_body_entered(body: Node3D) -> void:
	if body is Enemy:
		#print_debug(body, "entered")
		if current_enemy == null:
			current_enemy = body
		enemies_in_range.append(body)
		#print(enemies_in_range.size())
		#print(body.global_position)
		#look_at_2d(body.global_position)



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
