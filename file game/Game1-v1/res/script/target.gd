extends Area2D
@export var id = 0
@export var target = ""
signal box_correct(text,number)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("box"):
		if body.value == target:
			body.can_move = false
			box_correct.emit("[color=green]"+target+"[/color]",id)
		else:
			box_correct.emit("[color=red]"+target+"[/color]",id)
	pass 


func _on_body_exited(body: Node2D) -> void:
	box_correct.emit("_____",id)
