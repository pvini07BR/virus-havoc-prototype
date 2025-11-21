extends Stage

const shootingFolder = preload("res://scenes/viruses/ShootingFolder.tscn")
const planeBomber = preload("res://scenes/viruses/PaperZipBomber.tscn")

const popup = preload("res://scenes/viruses/CoveringPopup.tscn")
const ATTACKING_MESSAGES_PARENT = preload("uid://dnsa7qfhc8t2p")

var next_wave = 0

@onready var enemies: Node = $Enemies

@onready var folder_spawn_timer: Timer = $FolderSpawnTimer
@onready var paper_bomber_timer: Timer = $PaperBomberTimer

func _ready() -> void:
	wave_transition()
	
func enemy_exit(node: Node):
	if enemies.get_child_count() <= 1:
		enemies.child_exiting_tree.disconnect(enemy_exit)
		wave_transition()
	
func wave_transition() -> void:
	match next_wave:
		0:
			folder_spawn_timer.start()
			get_tree().create_timer(10).timeout.connect(func():
				folder_spawn_timer.stop()
				enemies.child_exiting_tree.connect(enemy_exit)
			)
		1:
			
			var attacking_messages = ATTACKING_MESSAGES_PARENT.instantiate() as AttackingMessageParent
			attacking_messages.position.x = 0
			attacking_messages.position.y = 720
			attacking_messages.size.x = 1280
			attacking_messages.size.y = 0
			attacking_messages.attacking_messages_parent_destroy.connect(wave_transition)
			add_child(attacking_messages)
			
			GameManager.get_player().lock_facing = false
		2:
			GameManager.get_player().direction = Player.Direction.RIGHT
			GameManager.get_player().lock_facing = true
			folder_spawn_timer.start()
			paper_bomber_timer.start()

	next_wave += 1

func _on_folder_spawn_timer_timeout() -> void:
	var inst = shootingFolder.instantiate() as CharacterBody2D
	inst.position.x = 1280
	randomize()
	inst.position.y = randi_range(15, 705)
	enemies.add_child(inst)

func _on_paper_bomber_timer_timeout() -> void:
	var inst = planeBomber.instantiate() as CharacterBody2D
	inst.position.x = 1280
	randomize()
	inst.position.y = randi_range(15, 180)
	enemies.add_child(inst)
	
	#inst = popup.instantiate() as Node2D
	#inst.position.x = randi_range(0, 960)
	#inst.position.y = randi_range(15, 480)
	#add_child(inst)
