@tool
extends Area2D

class_name HitSender

enum DamageMode {
	ONCE_PER_BODY,
	CONTINUOUS
}

@onready var colshape: CollisionShape2D = $colshape

@export var hitbox_shape: Shape2D = null:
	set(value):
		if hitbox_shape != value:
			if is_node_ready():
				colshape.shape = value
			hitbox_shape = value

@export var damage: float = 1.0
@export var mode: DamageMode = DamageMode.ONCE_PER_BODY
@export var delete_parent_at_hit: bool = true

var already_hit: Array[HitReceiver] = []

func _ready() -> void:
	colshape.shape = hitbox_shape

func _process(_delta: float) -> void:
	var can_delete := true
	var has_targets := false

	for area in get_overlapping_areas():
		if not area is HitReceiver:
			continue

		has_targets = true

		if mode == DamageMode.ONCE_PER_BODY:
			if not already_hit.has(area):
				area.receive_hit(damage)
				already_hit.append(area)
			if not already_hit.has(area):
				can_delete = false
		elif mode == DamageMode.CONTINUOUS:
			area.receive_hit(damage)

	if mode == DamageMode.ONCE_PER_BODY and delete_parent_at_hit and can_delete and has_targets:
		get_parent().queue_free()
