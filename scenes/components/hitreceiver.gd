extends Area2D

class_name HitReceiver

@export var health: Health = null

@export var cooldown_time: float = 0.0

@onready var cooldown_timer: Timer = $CooldownTimer

var damage_buffer: float = 0.0

var current_hit: HitSender = null

func _ready() -> void:
	if cooldown_time > 0.0:
		cooldown_timer.wait_time = cooldown_time
	
func receive_hit(damage: float):
	if !health: return
	
	health.damage(damage)
	
	if cooldown_time > 0.0 and cooldown_timer.is_stopped():
		health.invincible = true
		cooldown_timer.start()
	
func _on_cooldown_timer_timeout() -> void:
	health.invincible = false
