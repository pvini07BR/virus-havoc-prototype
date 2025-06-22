extends Node2D

var bullet = preload("res://scenes/bullets/laser_bullet.tscn")

var acc_angle: float = 0.0

func _process(delta: float) -> void:
	acc_angle += delta/2.0

func _on_shoot_timer_timeout() -> void:
	var div = 12
	for i in range(div):
		shoot_bullet((TAU/div)*i+acc_angle)

func shoot_bullet(angle: float):
	var inst = bullet.instantiate() as Bullet
	inst.affects_enemies = false
	inst.affects_player = true
	inst.position = self.position
	inst.velocity = Vector2.from_angle(angle) * 500
	GameManager.spawn_bullet(inst)
