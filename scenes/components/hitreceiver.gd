extends Area2D

class_name HitReceiver

@export var health: Health = null
@export var cooldown_time: float = 0.0

var damage_buffer: float = 0.0
var timer: Timer = null

var current_hit: HitSender = null
	
func _ready():
	if cooldown_time > 0.0:
		timer = Timer.new()
		timer.wait_time = cooldown_time
		timer.one_shot = false
		timer.timeout.connect(_on_cooldown_timer_timeout)
		add_child(timer)
	
func receive_hit(damage: float):
	if !health: return
	
	health.damage(damage)
	
	if cooldown_time > 0.0 and timer != null and !health.invincible:
		health.invincible = true
		timer.start()
	
func _on_cooldown_timer_timeout() -> void:
	health.invincible = false
