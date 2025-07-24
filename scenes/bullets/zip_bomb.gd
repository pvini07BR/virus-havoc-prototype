extends Bullet

var explosion = preload("res://scenes/bullets/Explosion.tscn")

@onready var sprite: Sprite2D = $Sprite

func _process(_delta: float) -> void:
	move_and_slide()
	
	despawn_itself()

func _on_touch_area_entered(area: Area2D) -> void:	
	if area is HitReceiver:
		var inst = explosion.instantiate() as Bullet
		inst.global_position = self.global_position
		GameManager.spawn_bullet(inst)
		self.queue_free()
