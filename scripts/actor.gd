@abstract class_name Actor extends Node2D

var tile_size := Vector2i(16,16)

@export var entity_resource:EntityResource
@onready var sprite_2d: Sprite2D = $Sprite2D

var map:Map

var grid_position:Vector2i:
	set(value):
		grid_position = value
		position = grid_position*tile_size
		
func _ready() -> void:
	grid_position = Vector2i(position)/tile_size
	
	sprite_2d.texture = entity_resource.texture
	
