extends Area2D

class_name HitReceiver

enum DamageMode {
	ACCUMULATE,
	COOLDOWN
}

@export var health: Health
@export var damage_mode: DamageMode

@onready var acc_timer: Timer = $AccumulateTimer
@onready var cooldown_timer: Timer = $CooldownTimer

var damage_buffer: float = 0.0

func _on_area_entered(area: Area2D) -> void:
	if health:
		if area is HitSender:
			if damage_mode != DamageMode.COOLDOWN:
				health.damage(area.damage)
			
			if cooldown_timer.is_stopped() and damage_mode == DamageMode.COOLDOWN:
				health.damage(area.damage)
				health.invincible = true
				cooldown_timer.start()
					
			if acc_timer.is_stopped():
				acc_timer.start()
				
			if damage_mode == DamageMode.ACCUMULATE:
				damage_buffer += area.damage
			area.delete_itself()

func _on_acc_timer_timeout() -> void:
	damage_buffer = 0.0
	
func _on_cooldown_timer_timeout() -> void:
	health.invincible = false
