extends CharacterBody2D

@onready var ray = $RayCast2D
@onready var sprite = $Sprite2D
@onready var coll = $CollisionShape2D

@export var size_x = 0
@export var size_y = 0

var delta_sensor = 20
var animation_speed = 0.35 #second
var moving = false
var tile_size = 32
var inputs = {"ui_right": [Vector2.RIGHT,"walk right"],
			"ui_left": [Vector2.LEFT,"walk left"],
			"ui_up": [Vector2.UP,"walk up"],
			"ui_down": [Vector2.DOWN,"walk down"]}
var direction
var last_direction
var box_status = false
var box_body

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	last_direction = direction
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir,true):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir][0] * (tile_size)
	ray.force_raycast_update()
			
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		action_move(dir)
	else:
		var col = ray.get_collider()
		if col.is_in_group("box"):
			if col.move(dir):
				action_move(dir)
	
func action_move(dir):
	$AnimationPlayer.play(inputs[dir][1])
	var tween = create_tween()
	tween.tween_property(self, "position",
		position + inputs[dir][0] * tile_size, animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
