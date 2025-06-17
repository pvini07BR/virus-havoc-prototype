extends CharacterBody2D

class_name Bullet

func despawn_itself() -> void:
	var rect = Rect2i(0, 0, GameManager.current_scene.bounds.x, GameManager.current_scene.bounds.y)
	if !rect.has_point(self.position):
		self.queue_free()
