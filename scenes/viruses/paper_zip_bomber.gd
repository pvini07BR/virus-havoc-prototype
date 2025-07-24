extends CharacterBody2D

var bomb = preload("res://scenes/bullets/ZipBomb.tscn")

@onready var zip_bomb_decoy: Sprite2D = $ZipBombDecoy

func _process(_delta: float) -> void:
	velocity.x = -400
	move_and_slide()
	
	if self.position.x < -23:
		queue_free()

func _on_scanning_body_entered(body: Node2D) -> void:
	if body == GameManager.get_player():
		var inst = bomb.instantiate()
		inst.position.x = self.position.x
		inst.position.y = self.position.y + 25
		inst.velocity.y = 400
		inst.z_index = self.z_index - 1
		GameManager.spawn_bullet(inst)
		zip_bomb_decoy.visible = false
