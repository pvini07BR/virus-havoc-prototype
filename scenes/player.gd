extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var small_ball: MeshInstance2D = $SmallBall

@onready var normal_shape: CollisionShape2D = $NormalShape
@onready var hit_normal_shape: CollisionShape2D = $HitReceiver/NormalShape

@onready var small_shape: CollisionShape2D = $SmallShape
@onready var hit_small_shape: CollisionShape2D = $HitReceiver/SmallShape

@onready var gun_manager = $Guns

var is_shrunk: bool = false

signal on_gun_changed(index: int)

func _ready() -> void:
	Input.set_use_accumulated_input(false)

func _process(delta: float) -> void:
	var input_axis = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	var vel =  input_axis * 400
	
	is_shrunk = Input.is_action_pressed("shrink")
	
	normal_shape.disabled = is_shrunk
	hit_normal_shape.disabled = is_shrunk
	small_shape.disabled = !is_shrunk
	hit_small_shape.disabled = !is_shrunk

	sprite.visible = !is_shrunk
	small_ball.visible = is_shrunk
	
	if is_shrunk:
		vel /= 3
		velocity = vel
	else:
		velocity = lerp(velocity, vel, 15 * delta)
	
	move_and_slide()

func get_health_component() -> Health:
	return get_node_or_null("Health")

func _on_guns_on_gun_changed(index: int) -> void:
	on_gun_changed.emit(index)
