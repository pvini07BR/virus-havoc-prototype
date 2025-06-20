extends Node2D

var bullet = preload("res://scenes/bullets/laser_bullet.tscn")

func _on_shoot_timer_timeout() -> void:
	if GameManager.get_player() != null:
		var inst = bullet.instantiate() as Bullet
		inst.z_index = self.z_index - 1
		inst.affects_enemies = false
		inst.affects_player = true
		inst.position = self.position
		var direction = self.position.direction_to(GameManager.get_player().position)
		inst.velocity = direction * 500
		GameManager.spawn_bullet(inst)
