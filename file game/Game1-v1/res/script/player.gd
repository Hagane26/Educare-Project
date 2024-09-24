extends CharacterBody2D

@onready var ray = $RayCast2D
@onready var sprite = $Sprite2D
@onready var coll = $CollisionShape2D

@export var size_x = 0
@export var size_y = 0

var delta_sensor = 20
var animation_speed = 3
var moving = false
var tile_size = 32
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

var direction
var last_direction
var box_status = false
var box_body
var count = 0
var col

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	last_direction = direction
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * (tile_size)
	ray.force_raycast_update()
	if box_status == true:
		count += 1
			
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		action_move(dir)
	else:
		col = ray.get_collider()
		if col.name == "Box":
			if col.move(dir):
				action_move(dir)
	
func action_move(dir):
	var tween = create_tween()
	tween.tween_property(self, "position",
		position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
		
func _on_sensor_body_entered(body):
	if body.name == "Box":
		box_status = true
		box_body = body

func _on_sensor_body_exited(body):
	box_status = false
	box_body = null
	count = 0
	
