extends Area2D

class_name HitSender

@export var damage: float = 1.0

func _ready() -> void:
	pass

func delete_itself():
	get_parent().queue_free()
