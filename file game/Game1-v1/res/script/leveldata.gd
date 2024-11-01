extends Node

var  levels = SaveData.new()


func _ready() -> void:
	levels = levels.load()

func get_data():
	return levels.data
	
func update_level(time:int,level:int):
	
	if time < levels.data[level][1]:
		levels.data[level][1] = time
	
	var nextlevel = level+1
	if nextlevel < len(levels.data):
		unlock_level(nextlevel)
	else:
		levels.save()

func unlock_level(level):
	levels.data[level][0] = true
	levels.save()
