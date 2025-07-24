extends Node

var current_scene = null

func _ready() -> void:
	current_scene = get_tree().root.get_child(3)
	
func switch_scene_packed_scene(new_scene: PackedScene):
	switch_scene_instance(new_scene.instantiate())
	
func switch_scene_instance(new_scene: Node):
	current_scene.queue_free()
	current_scene = new_scene
	get_tree().root.add_child(current_scene)

func spawn_bullet(bullet: Bullet):
	if current_scene is Game:
		current_scene.spawn_bullet(bullet)
		
func get_player() -> CharacterBody2D:
	if current_scene is Game:
		return current_scene.get_node_or_null("Player")
	else:
		return null
