extends Node2D

class_name Stage

@export var bounds: Vector2i = Vector2i(1280, 720)

func _ready():
	self.z_index = -2
