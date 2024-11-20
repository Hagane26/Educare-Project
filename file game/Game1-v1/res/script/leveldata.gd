extends Node

var  levels = SaveData.new()


func _ready() -> void:
	levels = levels.load()

func get_leaderboard(level):
	return levels.data[level][1] 

func get_data():
	return levels.data
	
func update_level(time:int,level:int):
	var leaderboard :Array = levels.data[level][1]
	
	if len(leaderboard) < 4 :
		leaderboard.append([CFGmanager.get_player_name(),time])
	
	elif time < leaderboard[-1]:
		leaderboard[-1] = [CFGmanager.get_player_name(),time]
		leaderboard.sort_custom(func(a,b): return a[1] > b[1])
	
	levels.data[level][1] =leaderboard
	var nextlevel = level+1
	if nextlevel < len(levels.data):
		unlock_level(nextlevel)
	else:
		levels.save()
func get_next_level(level):
	if level+1 < len(levels.data):
		return level+1
	else:
		return null
	
func unlock_level(level):
	levels.data[level][0] = true
	levels.save()
