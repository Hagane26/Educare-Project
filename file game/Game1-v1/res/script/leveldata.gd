extends Node

var  leveldata = ConfigFile.new()
var defaulleveldata ={
	0:[true,0],
	1:[false,0],
	2:[false,0],
	3:[false,0],
	4:[false,0],}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var err = leveldata.load("user://leveldata.cfg")
	if err == 7:
		for i in defaulleveldata:
			leveldata.set_value(str(i),"time",defaulleveldata[i][1])
			leveldata.set_value(str(i),"unlock",defaulleveldata[i][0])
			leveldata.save("user://leveldata.cfg")

func update_level(time:int,level:String):
	leveldata.set_value(level,"time",time)
	leveldata.save("user://leveldata.cfg")
	var nextlevel = str(int(level)+1)
	if nextlevel in leveldata.get_sections():
		unlock_level(nextlevel)

func unlock_level(level):
	leveldata.set_value(level,"unlock",true)
	leveldata.save("user://leveldata.cfg")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
