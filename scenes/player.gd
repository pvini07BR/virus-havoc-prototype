extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var small_ball: MeshInstance2D = $SmallBall

@onready var normal_shape: CollisionShape2D = $NormalShape
@onready var hit_normal_shape: CollisionShape2D = $HitReceiver/NormalShape

@onready var small_shape: CollisionShape2D = $SmallShape
@onready var hit_small_shape: CollisionShape2D = $HitReceiver/SmallShape

var is_shrunk: bool = false

func _ready() -> void:
	Input.set_use_accumulated_input(false)

func _process(delta: float) -> void:
	var input_axis = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	var vel =  input_axis * 400
	
	is_shrunk = Input.is_action_pressed("shrink")
	
	if is_shrunk:
		vel /= 4
		
	normal_shape.disabled = is_shrunk
	hit_normal_shape.disabled = is_shrunk
	small_shape.disabled = !is_shrunk
	hit_small_shape.disabled = !is_shrunk

	sprite.visible = !is_shrunk
	small_ball.visible = is_shrunk
		
		
	velocity = lerp(velocity, vel, 15 * delta)
	
	move_and_slide()

func get_health_component() -> Health:
	return get_node_or_null("Health")
