extends Node2D

signal pill_collected
signal ghost_contact
signal activate_big_pill

@export var collected_pills := 0
@export var lives := 3

@export var ghost_mode = "default"

var timer

func _ready():
	Manager.connect("pill_collected", increment_pill_count)
	Manager.connect("ghost_contact", handle_ghost_contact)
	Manager.connect("activate_big_pill", big_pill_activate)
	
func increment_pill_count():
	collected_pills += 1
	if collected_pills == 246:
		print("YOU WIN")
		
func handle_ghost_contact():
	if ghost_mode == "default":
		lose_life()
	elif ghost_mode == "agro":
		print("collected ghost")

		
func lose_life():
	lives -= 1
	print("life lost")
	if lives == 0:
		print("YOU LOSE")
		lives = 3
	else:
		get_tree().reload_current_scene()	

func big_pill_activate():
	ghost_mode = "agro"
	var original_sprite_textures = []
	var ghostCollection = get_node("/root/Main/Ghosts")
	for ghost in ghostCollection.get_children():
		original_sprite_textures.append(ghost.get_child(0).get_child(0).texture)
		ghost.get_child(0).get_child(0).texture = load("res://Sprites/ghosts/blue_ghost.png")
	
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 6
	timer.start()
	await timer.timeout
	
	ghost_mode = "default"
	for index in ghostCollection.get_children().size():
		var ghost = ghostCollection.get_children()[index]
		ghost.get_child(0).get_child(0).texture = original_sprite_textures[index]
