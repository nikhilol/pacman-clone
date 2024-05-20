extends Node2D

@onready var sprite = $Sprite2D

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	sprite.texture = load("res://Sprites/tiles/floor-tile-empty.svg")
	pass # Replace with function body.
	

func _on_sprite_2d_texture_changed():
	Manager.pill_collected.emit()
	pass # Replace with function body.
