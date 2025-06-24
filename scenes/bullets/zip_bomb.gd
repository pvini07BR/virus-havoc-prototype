extends Bullet

var explosion = preload("res://scenes/bullets/Explosion.tscn")

func _on_touch_area_entered(area: Area2D) -> void:
	if area is HitReceiver:
		var inst = explosion.instantiate() as Bullet
		get_parent().call_deferred("add_child", inst)
		inst.global_position = self.global_position
		self.queue_free()
