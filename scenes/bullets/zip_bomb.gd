extends BulletBehavior

var explosion = preload("res://scenes/bullets/Explosion.tscn")

@onready var sprite: Sprite2D = $Sprite

func _on_touch_area_entered(area: Area2D) -> void:	
	if area is HitReceiver:
		var inst = explosion.instantiate() as BulletBehavior
		inst.global_position = self.global_position
		GameManager.spawn_bullet(inst)
		self.queue_free()
