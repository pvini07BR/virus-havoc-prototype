extends CharacterBody2D

class_name Bullet

@export var hit_sender: HitSender

@export var affects_player: bool = false :
	set(value):
		hit_sender.set_collision_layer_value(1, affects_player)
		hit_sender.set_collision_mask_value(1, affects_player)
		affects_player = value
		
@export var affects_enemies: bool = false :
	set(value):
		hit_sender.set_collision_layer_value(2, affects_enemies)
		hit_sender.set_collision_mask_value(2, affects_enemies)
		affects_enemies = value

func _ready() -> void:
	if hit_sender:
		hit_sender.set_collision_layer_value(1, affects_player)
		hit_sender.set_collision_layer_value(2, affects_enemies)
		
		hit_sender.set_collision_mask_value(1, affects_player)
		hit_sender.set_collision_mask_value(2, affects_enemies)

func despawn_itself() -> void:
	var rect = Rect2i(0, 0, GameManager.current_scene.bounds.x, GameManager.current_scene.bounds.y)
	if !rect.has_point(self.position):
		self.queue_free()
