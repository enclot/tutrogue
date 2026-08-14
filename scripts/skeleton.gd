@tool
class_name Skeleton
extends Actor

func get_action() -> Action:
	return MovementAction.new(Vector2i.ZERO)
