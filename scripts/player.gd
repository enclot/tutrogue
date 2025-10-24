class_name Player
extends Node2D

var tile_size := Vector2i(16,16)

var grid_position:Vector2i:
	set(value):
		grid_position = value
		position = grid_position*tile_size
		
func move(offset:Vector2i) -> bool:
	var current_tile:Vector2i = grid_position
	var target_tile:Vector2i = current_tile+offset
	
	grid_position = target_tile
	return true
