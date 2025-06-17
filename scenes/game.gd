extends Node2D

class_name Game

@export var bounds: Vector2i = Vector2(1280, 720)

func spawn_bullet(bullet: Bullet):
	$Bullets.add_child(bullet)
