extends Control

@onready var timer = $Timer
@onready var tx = $Panel/Label
@onready var tx2 = $Panel/Label2

@export var sec = 0
@export var min = 0
var box = 0

func _ready() -> void:
	timer.start(1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tx2.text = "Jumlah Box : " + str(box)
	pass

func _on_timer_timeout() -> void:
	sec -= 1
	if sec == 0:
		min -= 1
		sec = 60
	tx.text = "Your Time " + str(min) + " : " + str(sec)
	if min == 0:
		timer.stop
	pass # Replace with function body.

func _on_target_box_correct() -> void:
	box += 1
	pass # Replace with function body.
