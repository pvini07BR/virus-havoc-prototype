extends Node

var current_scene = null

func _ready() -> void:
	current_scene = get_tree().root.get_child(3)
	
func switch_scene(new_scene: PackedScene):
	current_scene.queue_free()
	current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)

func spawn_bullet(bullet: Bullet):
	if current_scene is Game:
		current_scene.spawn_bullet(bullet)
		
func get_player():
	if current_scene is Game:
		return current_scene.get_node_or_null("Player")
	else:
		return null
