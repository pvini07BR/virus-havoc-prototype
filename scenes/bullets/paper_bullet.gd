extends Bullet

func _process(_delta: float) -> void:
	self.rotation = self.velocity.angle()
	move_and_slide()
	
	despawn_itself()
