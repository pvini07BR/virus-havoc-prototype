extends Node2D

var bullet = preload("res://scenes/bullets/laser_bullet.tscn")

@onready var sprite: Sprite2D = $Sprite

func _process(delta: float) -> void:
	sprite.rotation += delta/2.0

func _on_shoot_timer_timeout() -> void:
	var div = 12
	for i in range(div):
		shoot_bullet((TAU/div)*i+sprite.rotation)

func shoot_bullet(angle: float):
	var inst = bullet.instantiate() as Bullet
	inst.affects_enemies = false
	inst.affects_player = true
	inst.position = self.position
	inst.velocity = Vector2.from_angle(angle) * 500
	GameManager.spawn_bullet(inst)
