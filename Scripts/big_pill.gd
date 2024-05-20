extends Node2D

@onready var sprite = $BigPillSprite

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	sprite.texture = load("res://Sprites/tiles/floor-tile-empty.svg")
	pass # Replace with function body.
	

func _on_sprite_2d_texture_changed():
	print("HIT")
	Manager.activate_big_pill.emit()
	pass # Replace with function body.
