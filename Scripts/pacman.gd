extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var tilemap = $"../TileMap"

@onready var rcr = $ShapecastRight
@onready var rcl = $ShapecastLeft
@onready var rcu = $ShapecastUp
@onready var rcd = $ShapecastDown

@export var speed = 100000
var current_direction = Vector2(0.0, 0.0)
# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.play()

func _physics_process(delta):
	if Input.is_action_pressed("ui_left") && !rcl.is_colliding():
		current_direction = Vector2(-1 , 0.0)
		_animated_sprite.flip_v = true
	elif Input.is_action_pressed("ui_right") && !rcr.is_colliding():
		current_direction = Vector2(1, 0.0)
		_animated_sprite.flip_v = false
	elif Input.is_action_pressed("ui_up") && !rcu.is_colliding():
		current_direction = Vector2(0.0, -1)
		_animated_sprite.flip_v = false
	elif Input.is_action_pressed("ui_down") && !rcd.is_colliding():
		current_direction = Vector2(0.0, 1)
		_animated_sprite.flip_v = false
		
	velocity = current_direction * speed * delta
	_animated_sprite.rotation = velocity.angle()
	move_and_slide()



func _ghost_collision(body):
	if Manager.ghost_mode == "agro":
		body.get_parent().queue_free()
	Manager.ghost_contact.emit()
	pass # Replace with function body.
