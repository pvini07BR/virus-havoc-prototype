extends CanvasLayer

@onready var player = get_parent().player
@onready var hp_bar: ProgressBar = $HP

func _ready() -> void:
	hp_bar.max_value = player.get_health_component().max_health
	hp_bar.value = player.get_health_component().health
	player.get_health_component().on_damage.connect(on_player_damage)
	
func on_player_damage(_amount: float, new_hp: float):
	hp_bar.value = new_hp
