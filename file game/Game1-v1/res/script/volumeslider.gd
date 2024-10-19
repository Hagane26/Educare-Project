extends HSlider

@export var bus = "Master"
# Called when the node enters the scene tree for the first time.
@onready var _bus = AudioServer.get_bus_index(bus)
func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus))

func  _on_value_changed(value: float):
	AudioServer.set_bus_volume_db(_bus,linear_to_db(value))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(AudioServer.get_bus_volume_db(_bus))
