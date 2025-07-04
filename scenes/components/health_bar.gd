extends ProgressBar

@export var health: Health

@onready var fill: StyleBoxFlat = get("theme_override_styles/fill")

func _ready() -> void:
	self.visible = false
	if health:
		self.max_value = health.max_health
		self.value = health.health
		health.on_damage.connect(_on_health_damage)
		
		if self.value < self.max_value:
			self.visible = true

func _on_health_damage(_amount: float, new_hp: float):
	self.value = new_hp

func _on_value_changed(val: float) -> void:
	fill.bg_color = Color.RED.lerp(Color.GREEN, val / max_value)
	
	if val < self.max_value:
		self.visible = true
