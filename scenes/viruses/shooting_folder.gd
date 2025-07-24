extends CharacterBody2D

var bullet = preload("res://scenes/bullets/PaperBullet.tscn")
var shooted = false

@onready var shoot_timer: Timer = $ShootTimer

func _ready() -> void:
	randomize()
	var t = create_tween() \
		.tween_property(self, "position:x", randi_range(640, 1260), 1.0) \
		.from(self.position.x) \
		.set_trans(Tween.TRANS_CUBIC) \
		.set_ease(Tween.EASE_OUT)
	await t.finished
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:
	if !shooted:
		var player = GameManager.get_player()
		if player != null:
			var inst = bullet.instantiate() as Bullet
			inst.affects_enemies = false
			inst.affects_player = true
			inst.position = self.position
			inst.velocity = (player.global_position - self.global_position).normalized() * 500
			GameManager.spawn_bullet(inst)
		shooted = true
	else:
		self.queue_free()
