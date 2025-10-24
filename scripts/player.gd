class_name Player
extends Node2D

var tile_size := Vector2i(16,16)

@onready var map: Map = $"../Map"


var grid_position:Vector2i:
	set(value):
		grid_position = value
		position = grid_position*tile_size
		
func move(offset:Vector2i) -> bool:
	var current_tile:Vector2i = grid_position
	var target_tile:Vector2i = current_tile+offset
	
	if not map.is_walkable(target_tile):
		return false
	
	grid_position = target_tile
	return true

func _ready() -> void:
	grid_position = Vector2i(position)/tile_size
