@tool
class_name Player
extends Actor

var input_handler:GameInputHandler


func get_action() -> Action:
	return await input_handler.action_selected

func move(_offset:Vector2i) -> bool:
	var target_pos:Vector2i = grid_position +_offset
	if map.is_walkable(target_pos):
		grid_position = target_pos
		return true
	return false
