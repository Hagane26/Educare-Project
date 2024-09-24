extends CharacterBody2D

@onready var ray = $RayCast2D

var animation_speed = 3
var moving = false
var tile_size = 32
var status = true

var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func move(dir):
	ray.target_position = inputs[dir] * (tile_size)
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		animate_move(dir)
		return true
	else:
		return false
	
func animate_move(dir):
	var tween = create_tween()
	tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
