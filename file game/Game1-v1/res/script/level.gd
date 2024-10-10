extends Node

var simultaneous_scene = preload("res://res/scene/world_test.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_child(simultaneous_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
