extends Gun

var bullet = preload("res://scenes/bullets/laser_bullet.tscn")
var cooldown: bool = false

@onready var shoot_point: Marker2D = $ShootPoint
@onready var cooldown_timer: Timer = $CooldownTimer

func shoot_down() -> void:
	if !cooldown:
		var inst = bullet.instantiate() as Bullet
		inst.affects_player = false
		inst.affects_enemies = true
		GameManager.spawn_bullet(inst)
		inst.z_index = self.z_index - 1
		inst.global_position = shoot_point.global_position
		inst.modulate = Color.RED
		cooldown_timer.start()
		cooldown = true

func _on_timer_timeout() -> void:
	cooldown = false
