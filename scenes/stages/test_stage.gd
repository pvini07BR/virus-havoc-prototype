extends Stage

var shootingFolder = preload("res://scenes/viruses/ShootingFolder.tscn")
var planeBomber = preload("res://scenes/viruses/PaperZipBomber.tscn")

func _on_folder_spawn_timer_timeout() -> void:
	var inst = shootingFolder.instantiate() as CharacterBody2D
	inst.position.x = 1280
	randomize()
	inst.position.y = randi_range(0, 720)
	add_child(inst)
	
func _on_plane_bomber_spawn_timer_timeout() -> void:
	var inst = planeBomber.instantiate() as CharacterBody2D
	inst.position.x = 1280
	randomize()
	inst.position.y = randi_range(11, 180)
	add_child(inst)
