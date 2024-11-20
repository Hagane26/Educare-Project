extends Node
@export var levels :Array[PackedScene] = []
@export var box_count = 1
@export var level = 0
@export var default_sec = 0
@export var default_bns_timer = 60
var text = ""
var next_level
@onready var gui = $Control/GUI
@onready var lvlmgr = $Lvlmgr
@onready var timer = $Control/GUI/Timer
@onready var tx =$Control/GUI/Panel/HBoxContainer/VBoxContainer/timer
@onready var txbns = $Control/GUI/Panel/HBoxContainer/VBoxContainer/bonus
@onready var tx2 = $Control/GUI/Panel/HBoxContainer/Label2
@onready var tx3 = $Control/GUI/Panel/HBoxContainer/Label3
var max_level
@onready var finishmenu = $"Control/finished menu"
@onready var lbwin1 = $"Control/finished menu/Panel/Panel/VBoxContainer/Label"
@onready var lbwin2 = $"Control/finished menu/Panel/Panel/VBoxContainer/Label2"
var curr_level = 0
var boxes = {}
var correct_count = []
var box = 0
var bns_timer
var time_bns = 45
var sec
var sec_elapsed = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/pause_menu.visible = false
	finishmenu.visible = false
	max_level = len(levels)
	next_level = lvldata.get_next_level(level)
	bns_timer = default_bns_timer
	sec = default_sec
	print(len(levels))
	# randomize level
	randomize()
	levels.shuffle()
	print(levels)
	
	advance_level()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_reset") and not get_tree().paused:
		reset_puzzle()
	if Input.is_key_pressed(KEY_ESCAPE):
		_on_pause_button_pressed()
	tx2.text = text.format(boxes)
	
	if !get_tree().paused:
		sec = sec-delta
		if bns_timer >= 0:
			bns_timer = bns_timer-delta
		sec_elapsed += delta
		tx.text = "Your Time %02d:%02d" % [sec/60, fmod(sec,60)]
		txbns.text = "Bonus Time %02d:%02d" % [bns_timer/60, fmod(bns_timer,60)]
		
	if sec <= 0:
		fail_game()
		
func reset_puzzle():
	var current_child = lvlmgr.get_child(0)
	$AnimationPlayer.play("transition_out")
	await $AnimationPlayer.animation_finished
	lvlmgr.remove_child(current_child)
	current_child.queue_free()
	lvlmgr.add_child(levels[curr_level].instantiate())
	initialize_text(lvlmgr.get_child(0))
	$AnimationPlayer.play("transition_in")
	
func reset_level():
	get_tree().paused = true
	var current_child = lvlmgr.get_child(0)
	$AnimationPlayer.play("transition_out")
	await $AnimationPlayer.animation_finished
	finishmenu.visible = false
	lvlmgr.remove_child(current_child)
	current_child.queue_free()
	sec = default_sec
	curr_level = 0
	lvlmgr.add_child(levels[curr_level].instantiate())
	initialize_text(lvlmgr.get_child(0))
	$AnimationPlayer.play("transition_in")
	get_tree().paused = false
	
func advance_level():
	
	var current_child = lvlmgr.get_child(0)
	get_tree().paused = true
	if current_child:
		curr_level += 1	
		if curr_level >= len(levels):
			finish_game()
			return
		if bns_timer > 0:
			sec += time_bns
		bns_timer = default_bns_timer
		tx3.text = "Pertanyaan %s dari 5" % (curr_level+1)
		$AnimationPlayer.play("transition_out")
		await $AnimationPlayer.animation_finished
		lvlmgr.remove_child(current_child)
		current_child.queue_free()
	lvlmgr.add_child(levels[curr_level].instantiate())
	initialize_text(lvlmgr.get_child(0))
	$AnimationPlayer.play("transition_in")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false

func initialize_text(puzzle):
	text = puzzle.text
	box_count = puzzle.box_count
	correct_count = []
	$Control/fact/p/text.text = "[fill]"+puzzle.fact+"[/fill]"
	for i in range(box_count):
		boxes[i] = "[u][___%s___][/u]" %(i+1)
		correct_count.append(false)
	for target in puzzle.get_node("TargetHandler").get_children():
		target.box_correct.connect(_on_target_box_correct)
		
func finish_game() -> void:
	lvldata.update_level(int(sec_elapsed),level)
	get_tree().paused = true
	if next_level:
		$"Control/finished menu/Panel/Panel/VBoxContainer/next".visible = true
	finishmenu.visible = true
	lbwin2.text ="You finished the level with %02d:%02d left!" % [(default_sec-sec_elapsed)/60, fmod((default_sec-sec_elapsed),60)]

func fail_game() -> void:
	get_tree().paused = true
	finishmenu.visible = true
	lbwin1.text = "Time up!"
	lbwin2.text = "" 

func _on_target_box_correct(new_text,id,state) -> void:
	boxes[id] = new_text
	correct_count[id] = state
	if correct_count.count(true) == len(correct_count):
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true
		$Control/fact.visible = true
	pass


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	$Control/pause_menu.visible = true

func _on_resume_pressed() -> void:
	get_tree().paused = false
	$Control/pause_menu.visible = false

func _on_reset_pressed() -> void:
	$Control/pause_menu.visible = false
	finishmenu.visible = false
	get_tree().paused = false
	reset_level()
func _next_pressed():
	get_tree().change_scene_to_packed(load("res://res/scene/level"+str(next_level)+".tscn"))
	
func _enter_tree() -> void:
	audioplayer.play_music("res://assets/8_bit_ice_cave_lofi.mp3")
	
func _on_select_level_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(load("res://res/Interface/level_tscn.tscn"))
	pass # Replace with function body.


func _on_adv_pressed() -> void:
	$Control/fact.visible = false
	advance_level()
