extends Node
@export var levels :Array[PackedScene] = []
@export var box_count = 1
@export var level = 0
@export var default_sec = 0
var text = ""
@onready var gui = $Control/GUI
@onready var lvlmgr = $Lvlmgr
@onready var timer = $Control/GUI/Timer
@onready var tx = $Control/GUI/Panel/HBoxContainer/Label
@onready var tx2 = $Control/GUI/Panel/HBoxContainer/Label2
@onready var tx3 = $Control/GUI/Panel/HBoxContainer/Label3
@export var max_level = 5
@onready var lbwin1 = $"Control/finished menu/Panel/Panel/VBoxContainer/Label"
@onready var lbwin2 = $"Control/finished menu/Panel/Panel/VBoxContainer/Label2"
var curr_level = 0
var boxes = {}
var correct_count = []
var box = 0
var sec
var sec_elapsed = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/pause_menu.visible = false
	$"Control/finished menu".visible = false
	advance_level()
	sec = default_sec
	print(len(levels))
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and not get_tree().paused:
		reset_puzzle()
	
	tx2.text = text.format(boxes)
	
	if !get_tree().paused:
		sec = sec-delta
		sec_elapsed += delta
		tx.text = "Your Time %02d:%02d" % [sec/60, fmod(sec,60)]
		
	if sec <= 0:
		fail_game()
		
func reset_puzzle():
	var current_child = lvlmgr.get_child(0)
	$AnimationPlayer.play("transition_out")
	await $AnimationPlayer.animation_finished
	lvlmgr.remove_child(current_child)
	current_child.queue_free()
	lvlmgr.add_child(levels[curr_level].instantiate())
	initialize_text(lvlmgr.get_child(0).text,lvlmgr.get_child(0).box_count,lvlmgr.get_child(0).get_node("TargetHandler"))
	$AnimationPlayer.play("transition_in")
	
func reset_level():
	var current_child = lvlmgr.get_child(0)
	$AnimationPlayer.play("transition_out")
	await $AnimationPlayer.animation_finished
	lvlmgr.remove_child(current_child)
	current_child.queue_free()
	curr_level = 0
	lvlmgr.add_child(levels[curr_level].instantiate())
	initialize_text(lvlmgr.get_child(0).text,lvlmgr.get_child(0).box_count,lvlmgr.get_child(0).get_node("TargetHandler"))
	$AnimationPlayer.play("transition_in")
	
	
func advance_level():
	
	var current_child = lvlmgr.get_child(0)
	
	get_tree().paused = true
	if current_child:
		curr_level += 1	
		if curr_level >= len(levels):
			finish_game()
			return
		tx3.text = "Pertanyaan %s dari 5" % (curr_level+1)
		$AnimationPlayer.play("transition_out")
		await $AnimationPlayer.animation_finished
		lvlmgr.remove_child(current_child)
		current_child.queue_free()
	lvlmgr.add_child(levels[curr_level].instantiate())
	initialize_text(lvlmgr.get_child(0).text,lvlmgr.get_child(0).box_count,lvlmgr.get_child(0).get_node("TargetHandler"))
	$AnimationPlayer.play("transition_in")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false

func _on_button_pressed() -> void:
	advance_level()

func initialize_text(texts:String,box_counts:int,targets):
	text = texts
	box_count = box_counts
	correct_count = []
	for i in range(box_count):
		boxes[i] = "[u][___%s___][/u]" %(i+1)
		correct_count.append(false)
	for target in targets.get_children():
		target.box_correct.connect(_on_target_box_correct)
		
func finish_game() -> void:
	get_tree().paused = true
	$"Control/finished menu".visible = true
	lvldata.update_level(int(sec_elapsed),level)
	lbwin2.text ="You finished the level with %02d:%02d left!" % [(sec_elapsed)/60, fmod((sec_elapsed),60)]
func fail_game() -> void:
	get_tree().paused = true
	$"Control/finished menu".visible = true
	lbwin1.text = "Time up!"
	lbwin2.text = "" 

func _on_target_box_correct(new_text,id,state) -> void:
	boxes[id] = new_text
	correct_count[id] = state
	print(correct_count)
	if correct_count.count(true) == len(correct_count):
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true
		advance_level()
	pass


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	$Control/pause_menu.visible = true

func _on_resume_pressed() -> void:
	get_tree().paused = false
	$Control/pause_menu.visible = false

func _on_reset_pressed() -> void:
	get_tree().paused = false
	$Control/pause_menu.visible = false
	$"Control/finished menu".visible = false
	reset_level()
	
func _enter_tree() -> void:
	audioplayer.play_music("res://assets/8_bit_ice_cave_lofi.mp3")
	
func _on_select_level_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://res/Interface/level_tscn.tscn"))
	pass # Replace with function body.
