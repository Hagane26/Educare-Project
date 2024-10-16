extends Control

@onready var timer = $Timer
@onready var tx = $Panel/HBoxContainer/Label
@onready var tx2 = $Panel/HBoxContainer/Label2
@onready var tx3 = $Panel/HBoxContainer/Label3
var boxes = {}
var correct_count = {}
@export var text = ""
@export var box_count = 1
@export var sec = 0
var box = 0
signal time_runs_out

func _ready() -> void:
	#get_tree().root.get_node("level/puzzle").puzzle_initialized.connect()
	timer.start(1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func initialize_text(texts:String,box_counts:int,targets):
	text = texts
	box_count = box_counts
	for i in range(box_count):
		boxes[i] = "_______"
		correct_count[i] = false
	for target in targets.get_children():
		target.box_correct.connect(_on_target_box_correct)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tx2.text = text.format(boxes)
	pass

func _on_timer_timeout() -> void:
	#TODO : PAS NANTI TIMERNYA DI PAUSE PAS MUNCU MENU PAUSE
	sec -= 1
	if sec == 0:
		timer.stop()
		time_runs_out.emit()
	tx.text = "Your Time %02d:%02d" % [sec/60, sec%60] 
	pass # Replace with function body.

func _on_target_box_correct(text,id,state) -> void:
	boxes[id] = text
	correct_count[id] = state
	pass # Replace with function body.
func _set_current_value(texts, box_counts):
	tx2.text = texts
	box_count = box_counts
