@tool
class_name Player
extends Actor

var input_handler:GameInputHandler


func get_action() -> Action:
	return await input_handler.action_selected
