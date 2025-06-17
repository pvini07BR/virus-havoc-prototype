extends Gun

var bullet = preload("res://scenes/bullets/laser_bullet.tscn")
var cooldown: bool = false

@onready var shoot_point: Marker2D = $ShootPoint
@onready var cooldown_timer: Timer = $CooldownTimer

func shoot_down() -> void:
	if !cooldown:
		var inst = bullet.instantiate()
		GameManager.spawn_bullet(inst)
		inst.z_index = self.z_index - 1
		inst.global_position = shoot_point.global_position
		cooldown_timer.start()
		cooldown = true

func _on_timer_timeout() -> void:
	cooldown = false
