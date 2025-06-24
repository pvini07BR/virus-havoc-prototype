extends Stage

var enemy = preload("res://scenes/viruses/PaperZipBomber.tscn")

func _on_spawn_timer_timeout() -> void:
	var inst = enemy.instantiate()
	inst.position.x = 1200.0
	inst.position.y = 720.0 / 4.0
	add_child(inst)
