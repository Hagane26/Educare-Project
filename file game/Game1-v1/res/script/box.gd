extends CharacterBody2D

@onready var ray = $RayCast2D
@onready var label = $Label
@export var value = ""
@export var can_move = true
var animation_speed = 0.35
var moving = false
var tile_size = 32


var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	label.text = value

func move(dir):
	if can_move == true:
		ray.target_position = inputs[dir] * (tile_size)
		ray.force_raycast_update()
		if !ray.is_colliding():
			#position += inputs[dir] * tile_size
			audioplayer.play_sfx("res://assets/push.wav")
			animate_move(dir)
			return true
		else:
			return false
	
func animate_move(dir):
	var tween = create_tween()
	tween.tween_property(self, "position", position + inputs[dir] * tile_size, animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
	
