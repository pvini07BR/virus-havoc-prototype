extends CharacterBody2D

@onready var zip_bomb: CharacterBody2D = $ZipBomb

func _process(_delta: float) -> void:
	velocity.x = -400
	move_and_slide()

func _on_scanning_body_entered(body: Node2D) -> void:
	if body == GameManager.get_player():
		zip_bomb.top_level = true
		zip_bomb.global_position.x = global_position.x
		zip_bomb.global_position.y = global_position.y + 50
		zip_bomb.velocity.y = 400
		zip_bomb.disabled = false
