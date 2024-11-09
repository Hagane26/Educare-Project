extends Resource
class_name SaveData
const SAVE_DATA := "user://savedata.tres"
@export var data = {
	0:[true,0],
	1:[false,0],
	2:[false,0],
	3:[false,0],
	4:[false,0],
	5:[false,0],

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

	
	
