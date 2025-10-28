@abstract class_name Actor extends Node2D

var tile_size := Vector2i(16,16)

@export var entity_resource:EntityResource
@onready var sprite_2d: Sprite2D = $Sprite2D

var map:Map

var grid_position:Vector2i:
	set(value):
		grid_position = value
		position = grid_position*tile_size
		
var entity_name:String:
	get():
		return entity_resource.entity_name

func _ready() -> void:
	grid_position = Vector2i(position)/tile_size
	
	sprite_2d.texture = entity_resource.texture
	
func move(offset:Vector2i) -> bool:
	var current_tile:Vector2i = grid_position
	var target_tile:Vector2i = current_tile+offset
	
	if not map.is_walkable(target_tile):
		return false
	
	map.unregister_blocking_position(grid_position)
	grid_position = target_tile
	map.register_blocking_position(grid_position)
	return true
