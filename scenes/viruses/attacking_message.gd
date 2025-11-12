extends PanelContainer

class_name AttackingMessage

const SENDER_COLOR = Color.DODGER_BLUE
const RECEIVER_COLOR = Color.GREEN

var is_receiver := false
var typing_time = 1.0
var text = ""

@onready var label: Label = $Label
@onready var hit_sender_colshape: CollisionShape2D = $HitSender/CollisionShape2D
@onready var hit_recv_colshape: CollisionShape2D = $HitReceiver/CollisionShape2D
@onready var health: Health = $Health

signal message_sent
signal message_destroy

func _ready() -> void:
	var styleBox: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
	if is_receiver:
		styleBox.set("bg_color", RECEIVER_COLOR)
		size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	else:
		styleBox.set("bg_color", SENDER_COLOR)
		size_flags_horizontal = Control.SIZE_SHRINK_END
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	add_theme_stylebox_override("panel", styleBox)
	
	await get_tree().create_timer(typing_time).timeout
	message_sent.emit()
	health.invincible = false
	
	label.text = text

func _on_resized() -> void:
	var shape := CapsuleShape2D.new()
	
	shape.height = self.size.x
	shape.radius = self.size.y / 2.0
	
	hit_sender_colshape.position.x = self.size.x / 2.0
	hit_recv_colshape.position.x = self.size.x / 2.0
	
	hit_sender_colshape.shape = shape
	hit_recv_colshape.shape = shape

func _on_health_on_death() -> void:
	message_destroy.emit()
