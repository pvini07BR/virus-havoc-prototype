extends Area2D

class_name HitReceiver

@export var health: Health

func _on_area_entered(area: Area2D) -> void:
	if health:
		if area is HitSender:
			health.damage(area.damage)
			area.delete_itself()
