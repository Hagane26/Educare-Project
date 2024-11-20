extends Node

var  config = ConfigFile.new()
const SFX = "Sfx"
const MUSIC = "Music"
const MASTER = "Master"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Load data from a file.
	var err = config.load("user://config.cfg")
	
	# 7 stands for ERR_FILE_NOT_FOUND
	# make new file when no file present
	if err == 7:
		#init setting
		config.set_value("setting","Master",1.0)
		config.set_value("setting","Music",1.0)
		config.set_value("setting","Sfx",1.0)
		
		config.set_value("player","name","")
		config.save("user://config.cfg")
	for cfg in config.get_section_keys("setting"):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(cfg),linear_to_db(get_setting_val(cfg)))
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func  set_setting_val(field,val):
	config.set_value("setting",field,val)
	config.save("user://config.cfg")
	
func  get_setting_val(field):
	return config.get_value("setting",field)
	
func  get_player_name() -> String:
	return config.get_value("player","name")
	
func set_player_name(new_name):
	config.set_value("player","name",new_name)
