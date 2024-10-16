extends Area2D
@export var id = 0
@export var target :Array[String]= []
signal box_correct(data,number)
func  _ready() -> void:
	$Label.text = str(id+1)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("box"):
		if body.value in target:
			print("test")
			body.can_move = false
			box_correct.emit("[color=green]"+body.value+"[/color]",id,true)
		else:
			box_correct.emit("[color=red]"+body.value+"[/color]",id,false)

func _on_body_exited(body: Node2D) -> void:
	
	if body.is_in_group("box"):
		box_correct.emit("_____",id,false)
