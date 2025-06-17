extends Node

class_name Health

@export_range(0.0, 1.0, 1.0, "or_greater") var max_health: float
@export var invincible: bool = false
@onready var health: float = max_health

signal on_damage(amount: float, new_hp: float)
signal on_death

func damage(amount: float):
	if invincible: return
	
	health -= amount
	on_damage.emit(amount, health)
	
	if health <= 0.0:
		on_death.emit()
		get_parent().queue_free()
		
