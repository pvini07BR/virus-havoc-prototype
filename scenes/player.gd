extends CharacterBody2D

func _ready() -> void:
	Input.set_use_accumulated_input(false)

func _process(delta: float) -> void:
	var input_axis = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	velocity = lerp(velocity, input_axis * 400, 15 * delta)
	
	move_and_slide()
