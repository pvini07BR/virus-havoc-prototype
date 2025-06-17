extends CharacterBody2D

const MAX_HP: float = 10.0

var hp: float = 10.0

func _ready() -> void:
	Input.set_use_accumulated_input(false)

func _process(delta: float) -> void:
	var input_axis = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	velocity = lerp(velocity, input_axis * 400, 15 * delta)
	
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitWriter:
		if area.hit_player:
			print("Taken damage")
			hp -= area.damage
