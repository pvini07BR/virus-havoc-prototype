extends CanvasLayer

@onready var player = get_parent().player
@onready var hp_bar: ProgressBar = $VBoxContainer/HBoxContainer/HP
@onready var equipped: Label = $VBoxContainer/Equipped

func _ready() -> void:
	hp_bar.max_value = player.get_health_component().max_health
	hp_bar.value = player.get_health_component().health
	player.get_health_component().on_damage.connect(on_player_damage)
	
	_on_player_on_gun_changed(player.gun_manager.current_gun_index)
	
	for i in GunManager.equipped_guns.size():
		var label = Label.new()
		if GunManager.equipped_guns[i] > 0:
			label.text = "Slot " + str(i) + ": " + GunManager.guns[GunManager.equipped_guns[i]-1].name
		else:
			label.text = "Slot " + str(i) + ": (empty)"
		$VBoxContainer.add_child(label)
	
func on_player_damage(_amount: float, new_hp: float):
	hp_bar.value = new_hp

func _on_player_on_gun_changed(index: int) -> void:
	equipped.text = "Equipped slot: " + str(index)
