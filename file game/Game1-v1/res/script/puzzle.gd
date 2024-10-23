extends Node2D

var boxes = {}
@export var text = ""
@export var box_count = 1

@export var cam_limit :Array[int] = []
signal puzzle_initialized(texts, box_counts)
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	# when is loaded send singal to initialize the level
	puzzle_initialized.emit(text, box_count)
