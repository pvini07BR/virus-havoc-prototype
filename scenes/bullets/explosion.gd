extends Bullet

func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()
