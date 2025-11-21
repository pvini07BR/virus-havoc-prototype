extends Node2D

class_name Game

@export var player: CharacterBody2D

var stage_scene: Stage = null
var stage_index = 0

@onready var camera: Camera2D = $Camera2D

@onready var right_bound: WorldBoundaryShape2D = $Bounds/Right.shape
@onready var bottom_bound: WorldBoundaryShape2D = $Bounds/Bottom.shape

@onready var pause_menu: ColorRect = $UI/PauseMenu

func _ready():
	stage_scene = StageManager.stages[stage_index].scene.instantiate()
	
	right_bound.distance = -stage_scene.bounds.x
	bottom_bound.distance = -stage_scene.bounds.y
	
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = stage_scene.bounds.x
	camera.limit_bottom = stage_scene.bounds.y
	
	add_child(stage_scene)

func spawn_bullet(bullet: BulletBehavior):
	$Bullets.call_deferred("add_child", bullet)
	
func clear_bullets():
	for child in $Bullets.get_children():
		child.queue_free()
