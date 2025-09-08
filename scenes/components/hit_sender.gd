extends Area2D

class_name HitSender

enum DamageMode {
	# The sender will delete its parent with any receiver it collides with.
	DELETE_AT_HIT,
	# The sender will deal damage every frame to any receiver it collides with, every frame.
	EVERY_FRAME,
	# The sender will deal damage to any receiver it collides with, only once per receiver.
	ONCE_PER_RECEIVER
}

@export var damage: float = 1.0
@export var mode: DamageMode = DamageMode.DELETE_AT_HIT

var has_hit: Array[HitReceiver] = []

func _process(_delta: float) -> void:
	var receivers: Array[HitReceiver] = []
	for area in get_overlapping_areas():
		if area is HitReceiver:
			receivers.append(area)
			
	var damaged = false
			
	for r in receivers:
		if mode == DamageMode.ONCE_PER_RECEIVER:
			if not has_hit.has(r):
				r.receive_hit(damage)
				damaged = true
				has_hit.append(r)
		else:
			r.receive_hit(damage)
			damaged = true
		
	if mode == DamageMode.DELETE_AT_HIT and damaged:
		get_parent().queue_free()
		
