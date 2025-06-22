extends Area2D

class_name HitReceiver

enum DamageMode {
	ACCUMULATE,
	COOLDOWN
}

@export var health: Health = null
@export var damage_mode: DamageMode

@export var cooldown_time: float = 0.5
@export var accumulator_buffer_time = 0.1

@onready var acc_timer: Timer = $AccumulateTimer
@onready var cooldown_timer: Timer = $CooldownTimer

var damage_buffer: float = 0.0

var current_hit: HitSender = null

func _ready() -> void:
	cooldown_timer.wait_time = cooldown_time
	acc_timer.wait_time = accumulator_buffer_time
	
func _process(_delta: float) -> void:
	if !health: return
	
	for area in get_overlapping_areas():
		if not area is HitSender: continue
		
		health.damage(area.damage)
		
		if damage_mode == DamageMode.COOLDOWN and cooldown_timer.is_stopped():
			health.invincible = true
			cooldown_timer.start()
		elif damage_mode == DamageMode.ACCUMULATE:
			if acc_timer.is_stopped():
				acc_timer.start()
			damage_buffer += area.damage
			
		area.delete_itself()

func _on_acc_timer_timeout() -> void:
	damage_buffer = 0.0
	
func _on_cooldown_timer_timeout() -> void:
	health.invincible = false
