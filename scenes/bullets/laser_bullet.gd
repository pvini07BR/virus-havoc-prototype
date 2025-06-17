extends Bullet

func _process(_delta: float) -> void:
	velocity.x = 1000
	move_and_slide()
	
	despawn_itself()
