extends CharacterBody2D

class_name Bullet

@export var hit_writer: HitWriter

@export var affects_player: bool = false :
	set(value):
		hit_writer.set_collision_layer_value(1, affects_player)
		hit_writer.set_collision_mask_value(1, affects_player)
		affects_player = value
		
@export var affects_enemies: bool = false :
	set(value):
		hit_writer.set_collision_layer_value(2, affects_enemies)
		hit_writer.set_collision_mask_value(2, affects_enemies)
		affects_enemies = value

func _ready() -> void:
	if hit_writer:
		hit_writer.set_collision_layer_value(1, affects_player)
		hit_writer.set_collision_layer_value(2, affects_enemies)
		
		hit_writer.set_collision_mask_value(1, affects_player)
		hit_writer.set_collision_mask_value(2, affects_enemies)

func despawn_itself() -> void:
	var rect = Rect2i(0, 0, GameManager.current_scene.bounds.x, GameManager.current_scene.bounds.y)
	if !rect.has_point(self.position):
		self.queue_free()
