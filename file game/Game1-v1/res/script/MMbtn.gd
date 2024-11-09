extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(load("res://res/Interface/level_tscn.tscn"))
