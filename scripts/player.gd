@tool
class_name Player
extends Actor

var fov_radius:int = 8

func move(offset:Vector2i) -> bool:
	var current_tile:Vector2i = grid_position
	var target_tile:Vector2i = current_tile+offset
	
	if not map.is_walkable(target_tile):
		return false
	
	grid_position = target_tile
	return true
