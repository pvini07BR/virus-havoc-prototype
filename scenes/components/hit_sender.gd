extends Area2D

class_name HitSender

@export var damage: float = 1.0
@export var delete_parent_at_hit: bool = true

func _ready() -> void:
	pass

func delete_itself():
	if delete_parent_at_hit:
		get_parent().queue_free()
