extends Area2D

@export var target = ""
signal box_correct
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("box"):
		if body.value == target:
			body.can_move = false
			emit_signal('box_correct')
		else:
			print("no accept")
	pass 
