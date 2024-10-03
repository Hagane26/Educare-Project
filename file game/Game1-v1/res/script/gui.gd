extends Control

@onready var timer = $Timer
@onready var tx = $Panel/Label
@onready var tx2 = $Panel/Label2
var boxes = {}
@export var text = ""
@export var box_count = 1
@export var sec = 0
@export var min = 0
var box = 0

func _ready() -> void:
	for i in range(box_count):
		boxes[i] = "_______"
	print(boxes)
	timer.start(1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tx2.text = text.format(boxes)
	pass

func _on_timer_timeout() -> void:
	#TODO : PAS NANTI TIMERNYA DI PAUSE PAS MUNCU MENU PAUSE
	sec -= 1
	if sec == 0:
		min -= 1
		sec = 60
	tx.text = "Your Time " + str(min) + " : " + str(sec)
	if min == 0:
		timer.stop
	pass # Replace with function body.

func _on_target_box_correct(text,number) -> void:
	boxes[number] = text
	pass # Replace with function body.
