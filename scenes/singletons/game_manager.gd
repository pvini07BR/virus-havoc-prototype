extends Node

var current_scene = null

func _ready() -> void:
	current_scene = get_tree().root.get_node("Game")

func spawn_bullet(bullet: Bullet):
	if current_scene is Game:
		current_scene.spawn_bullet(bullet)
