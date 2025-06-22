extends CenterContainer

var game_scene = preload("res://scenes/Game.tscn")

@onready var gunlist: ItemList = $VBoxContainer/HBoxContainer/GunSelector/GunListVbox/GunList
@onready var stagelist: ItemList = $VBoxContainer/HBoxContainer/StageSelector/StageList

@onready var equip_guns: ItemList = $VBoxContainer/HBoxContainer/GunSelector/EquipGunVBox/EquipGuns

@onready var gun_list_vbox: VBoxContainer = $VBoxContainer/HBoxContainer/GunSelector/GunListVbox
@onready var empty_slot_button: Button = $VBoxContainer/HBoxContainer/GunSelector/EquipGunVBox/HBoxContainer/EmptySlot

func _ready():
	refresh_equipped_guns()
	
	for gun in GunManager.guns:
		gunlist.add_item(gun.name)
		
	for stage in StageManager.stages:
		stagelist.add_item(stage.name)
		
func _process(_delta: float) -> void:
	gun_list_vbox.visible = !equip_guns.get_selected_items().is_empty()
	empty_slot_button.visible = !equip_guns.get_selected_items().is_empty()

func refresh_equipped_guns():
	equip_guns.clear()
	for gun_index in GunManager.equipped_guns:
		if gun_index == 0:
			equip_guns.add_item("Empty")
		else:
			equip_guns.add_item(GunManager.guns[gun_index - 1].name)

func _on_play_button_pressed() -> void:
	GameManager.switch_scene(game_scene)

func _on_gun_list_item_selected(index: int) -> void:
	if !equip_guns.get_selected_items().is_empty():
		var selslot = equip_guns.get_selected_items()[0]
		GunManager.equipped_guns[selslot] = index+1
		refresh_equipped_guns()

func _on_empty_slot_button_pressed() -> void:
	if !equip_guns.get_selected_items().is_empty():
		var selslot = equip_guns.get_selected_items()[0]
		GunManager.equipped_guns[selslot] = 0
		refresh_equipped_guns()
		
func _on_add_slot_pressed() -> void:
	GunManager.equipped_guns.resize(GunManager.equipped_guns.size()+1)
	refresh_equipped_guns()
