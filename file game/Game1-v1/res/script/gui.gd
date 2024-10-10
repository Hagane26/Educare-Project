extends Control

@onready var timer = $Timer
@onready var tx = $Panel/HBoxContainer/Label
@onready var tx2 = $Panel/HBoxContainer/Label2
var boxes = {}
@export var text = ""
@export var box_count = 1
@export var sec = 0
var box = 0
signal time_runs_out

func _ready() -> void:
	#get_tree().root.get_node("level/puzzle").puzzle_initialized.connect()
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
		timer.stop
	tx.text = "Your Time " + str(sec/60) + " : " + str(sec%60) 
	pass # Replace with function body.

func _on_target_box_correct(text,number) -> void:
	boxes[number] = text
	pass # Replace with function body.
func _set_current_value(texts, box_counts):
	tx2.text = texts
	box_count = box_counts
