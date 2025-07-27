extends BulletBehavior

func bullet_proccess(_delta: float) -> void:
	self.rotation = self.velocity.angle()
