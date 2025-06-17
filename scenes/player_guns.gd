extends Node2D

var current_gun_index: int = 0 :
	set(value):
		if current_gun_index != value:
			if is_node_ready():
				get_child(current_gun_index).visible = false
				get_child(value).visible = true
			current_gun_index = value

func _ready() -> void:
	for i in GunManager.equipped_guns:
		if i == 0: continue
		var inst = GunManager.guns[i-1].scene.instantiate()
		inst.visible = false
		add_child(inst)
		
	get_child(current_gun_index).visible = true
		
func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if get_child(current_gun_index).has_method("shoot_down"):
			get_child(current_gun_index).shoot_down()
		
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("shoot"):
		if get_child(current_gun_index).has_method("shoot_press"):
			get_child(current_gun_index).shoot_presss()
	
	if Input.is_action_just_released("shoot"):
		if get_child(current_gun_index).has_method("shoot_release"):
			get_child(current_gun_index).shoot_release()
	
	if event.is_action_pressed("switch_gun_left"):
		if current_gun_index > 0:
			current_gun_index -= 1
		
	if event.is_action_pressed("switch_gun_right"):
		if current_gun_index < get_child_count() - 1:
			current_gun_index += 1
