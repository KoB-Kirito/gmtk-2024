extends Enemy


func _process(delta: float) -> void:
	# animation
	if velocity.is_zero_approx():
		%AnimationPlayer.play("0TPose")
		
	else:
		%AnimationPlayer.play("Run")
