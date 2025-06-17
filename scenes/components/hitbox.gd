extends Area2D

@export var health: Health

func _on_area_entered(area: Area2D) -> void:
	if health:
		if area is HitWriter:
			health.damage(area.damage)
			area.delete_itself()
