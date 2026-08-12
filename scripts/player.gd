class_name Player
extends Node2D

var input_handler:GameInputHandler

var tile_size := Vector2i(16,16)

var grid_position:Vector2i:
	set(value):
		grid_position = value
		position = grid_position*tile_size
		
func get_action() -> Action:
	return await input_handler.action_selected

func move(_offset:Vector2i) -> bool:
	var current_pos:Vector2i = grid_position
	var target_pos:Vector2i = current_pos+_offset
	grid_position = target_pos
	return true
