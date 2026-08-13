class_name Player
extends Node2D

var input_handler:GameInputHandler
var map:Map

var tile_size := Vector2i(16,16)

var grid_position:Vector2i:
	set(value):
		grid_position = value
		position = grid_position*tile_size

func _ready() -> void:
	@warning_ignore("integer_division")
	grid_position = Vector2i(position)/tile_size
	#grid_position = Vector2i(position / Vector2(tile_size))
		
func get_action() -> Action:
	return await input_handler.action_selected

func move(_offset:Vector2i) -> bool:
	var target_pos:Vector2i = grid_position +_offset
	if map.is_walkable(target_pos):
		grid_position = target_pos
		return true
	return false
