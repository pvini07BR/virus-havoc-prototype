extends Node2D

class_name Game

@export var player: CharacterBody2D
@export var bounds: Vector2i = Vector2(1280, 720)

func _ready():
	add_child(StageManager.stages[StageManager.stage_index].scene.instantiate())

func spawn_bullet(bullet: Bullet):
	$Bullets.add_child(bullet)
