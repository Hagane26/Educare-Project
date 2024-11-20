extends Resource
class_name SaveData
const SAVE_DATA := "user://save.tres"
@export var data = {
	0:[true,[]],
	1:[false,[]],
	2:[false,[]],
	3:[false,[]],
	4:[false,[]],

	}
func _ready():
	ResourceSaver.save(self,SAVE_DATA)



func save():
	ResourceSaver.save(self,SAVE_DATA)
	
func load():
	if ResourceLoader.exists(SAVE_DATA):
		return load(SAVE_DATA)
	else:
		return self

	
	
