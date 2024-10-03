extends Area2D
@export var id = 0
@export var target = ""
signal box_correct(text,number)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("box"):
		if body.value == target:
			body.can_move = false
			box_correct.emit(target,id)
		else:
			print("no accept")
	pass 
