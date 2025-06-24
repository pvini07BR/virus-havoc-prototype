extends CharacterBody2D

@onready var zip_bomb: CharacterBody2D = $ZipBomb

func _process(_delta: float) -> void:
	velocity.x = -400
	move_and_slide()
	
	if self.position.x < 0.0:
		queue_free()

func _on_scanning_body_entered(body: Node2D) -> void:
	if body == GameManager.get_player():
		zip_bomb.top_level = true
		zip_bomb.global_position.x = global_position.x + 1
		zip_bomb.global_position.y = global_position.y + 16
		zip_bomb.velocity.y = 400
		zip_bomb.z_index = self.z_index - 1
		zip_bomb.disabled = false
