extends Gun

var bullet = preload("res://scenes/bullets/laser_bullet.tscn")
var cooldown: bool = false

@onready var cooldown_timer: Timer = $CooldownTimer

@onready var top_shoot_point: Marker2D = $TopShootPoint
@onready var bottom_shoot_point: Marker2D = $BottomShootPoint

func shoot_bullet(pos: Vector2):
	var inst = bullet.instantiate()
	GameManager.spawn_bullet(inst)
	inst.z_index = self.z_index - 1
	inst.global_position = pos

func shoot_down():
	if !cooldown:
		shoot_bullet(top_shoot_point.global_position)
		shoot_bullet(bottom_shoot_point.global_position)
		cooldown_timer.start()
		cooldown = true

func _on_timer_timeout() -> void:
	cooldown = false
