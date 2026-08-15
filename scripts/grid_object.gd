@tool
class_name GridObject
extends Node2D
var tile_size := Vector2i(16,16)

@export var entity_resource:EntityResource
@onready var sprite_2d:Sprite2D = $Sprite2D

var grid_position:Vector2i:
	set(value):
		grid_position = value
		position = grid_position*tile_size

var entity_name:String:
	get():
		return entity_resource.entity_name

func _ready() -> void:
	grid_position = Vector2i(position / Vector2(tile_size))
	sprite_2d.texture = entity_resource.texture
