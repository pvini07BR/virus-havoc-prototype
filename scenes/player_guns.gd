extends Node2D

@onready var player = get_parent()

var current_gun_index: int = 0
var equipped_gun = null :
	set(value):
		if equipped_gun != value:
			if equipped_gun:
				equipped_gun.visible = false
			if value:
				value.visible = true
			equipped_gun = value

func _ready() -> void:
	for i in GunManager.equipped_guns:
		if i == 0: continue
		var inst = GunManager.guns[i-1].scene.instantiate()
		inst.visible = false
		add_child(inst)
		
	if get_child_count() > 0:
		equipped_gun = get_child(current_gun_index)
		if equipped_gun:
			equipped_gun.visible = true
		
func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and equipped_gun and !player.is_shrunk:
		if equipped_gun.has_method("shoot_down"):
			equipped_gun.shoot_down()
			
	if get_child_count() > 0:
		if equipped_gun:
			equipped_gun.visible = !player.is_shrunk
		
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("shoot") and equipped_gun and !player.is_shrunk:
		if equipped_gun.has_method("shoot_press"):
			equipped_gun.shoot_presss()
	
	if Input.is_action_just_released("shoot") and equipped_gun and !player.is_shrunk:
		if equipped_gun.has_method("shoot_release"):
			equipped_gun.shoot_release()
	
	if event.is_action_pressed("switch_gun_left"):
		if current_gun_index > 0:
			current_gun_index -= 1
			
		if get_child_count() > 0:
			equipped_gun = get_child(current_gun_index)
		
	if event.is_action_pressed("switch_gun_right"):
		if current_gun_index < get_child_count() - 1:
			current_gun_index += 1
			
		if get_child_count() > 0:
			equipped_gun = get_child(current_gun_index)
