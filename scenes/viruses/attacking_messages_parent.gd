extends VBoxContainer

class_name AttackingMessageParent

const ATTACKING_MESSAGE = preload("uid://mwo3pachmgu3")

const message_texts = [
	"Wassup bro!",
	"where are you?",
	"bro what the hell",
	"Hello, how are you?",
	"Hey, check this out!",
	"i miss you so much babe",
	"This is why we shouldn't.",
	"Will you come here tonight?",
	"have you seen this post lmao",
	"You have an appointment at 3 AM.",
]

var timer_value = 1.0
var count := 0

var inverse_cycle := false
var cycle_idx := 0
var inv_cycle_idx := (message_texts.size() - 1) - cycle_idx

@onready var timer: Timer = $Timer

signal attacking_messages_parent_destroy

func _on_timer_timeout() -> void:
	var inst = ATTACKING_MESSAGE.instantiate() as AttackingMessage
	
	inst.is_receiver = count % 2 == 0
	randomize()
	inst.typing_time = randf_range(timer_value - 0.5, timer_value + 0.5)
	randomize()
	timer.wait_time = clamp(randf_range(timer_value - 0.5, timer_value + 0.5), 0.2, timer_value)
	
	if !inst.is_receiver:
		inst.text = message_texts[inv_cycle_idx]
	else:
		inst.text = message_texts[cycle_idx]
	
	inst.message_destroy.connect(_on_message_destroy)
	inst.message_sent.connect(_on_message_sent)
	
	add_child(inst)
	
	count += 1
	
	if inst.is_receiver:
		if not inverse_cycle:
			cycle_idx += 1
			if cycle_idx >= message_texts.size() - 1:
				cycle_idx = message_texts.size() - 1
				inverse_cycle = true
		else:
			cycle_idx -= 1
			if cycle_idx <= 0:
				cycle_idx = 0
				inverse_cycle = false
				
		inv_cycle_idx = (message_texts.size() - 1) - cycle_idx
	
func _on_message_sent():
	timer.start()

func _on_message_destroy():
	if timer_value > 0.2:
		timer_value -= 0.1
	else:
		attacking_messages_parent_destroy.emit()
		self.queue_free()
