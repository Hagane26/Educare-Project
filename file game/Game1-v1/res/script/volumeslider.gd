extends HSlider

@export var bus = "Master"
# Called when the node enters the scene tree for the first time.
@onready var _bus = AudioServer.get_bus_index(bus)
func _ready() -> void:
	value = CFGmanager.get_setting_val(bus)
	AudioServer.set_bus_volume_db(_bus,linear_to_db(value))

func _on_value_changed(val: float):
	AudioServer.set_bus_volume_db(_bus,linear_to_db(val))
	CFGmanager.set_setting_val(bus,val)
