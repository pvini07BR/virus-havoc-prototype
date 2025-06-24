extends Bullet

var explosion = preload("res://scenes/bullets/Explosion.tscn")
var disabled = true

@onready var sprite: Sprite2D = $Sprite

func _process(_delta: float) -> void:
	move_and_slide()

func _on_touch_area_entered(area: Area2D) -> void:
	if disabled: return
	
	if area is HitReceiver:
		var inst = explosion.instantiate() as Bullet
		call_deferred("add_child", inst)
		velocity.y = 0
		disabled = true
		inst.top_level = true
		inst.global_position = self.global_position
		sprite.visible = false
