extends Node2D

var boxes = {}
@export_multiline var text = ""
@export var box_count = 1
@export var cam_limit :Array[int] = []
@export_multiline var fact = "lorem ipsum sir dolores amet"
signal puzzle_initialized(texts, box_counts)
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	# when is loaded send singal to initialize the level
	puzzle_initialized.emit(text, box_count)
	
func  _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_node("../..")
