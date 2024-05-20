extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

@onready var rcr = $ShapecastRight
@onready var rcl = $ShapecastLeft
@onready var rcu = $ShapecastUp
@onready var rcd = $ShapecastDown

@onready var tilemap = $"../TileMap"

@export var speed = 100000

var current_direction = Vector2(0, -1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
func _physics_process(delta):
	var possible = [current_direction]
	if !rcl.is_colliding() && current_direction.x == 0 :
		possible.append(Vector2(-1, 0))
	if !rcr.is_colliding() && current_direction.x == 0:
		possible.append(Vector2(1, 0))
	if !rcu.is_colliding() && current_direction.y == 0:
		possible.append(Vector2(0, -1))
	if !rcd.is_colliding() && current_direction.y== 0:
		possible.append(Vector2(0, 1))
		
	current_direction = possible.pick_random()
		
	velocity = current_direction * speed * delta
	move_and_slide()
