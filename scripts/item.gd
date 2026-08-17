@tool
@abstract class_name Item extends GridObject

@export var target_type: TargetType
var target_positions:Array[Vector2i]

@abstract func can_use(_user:Actor) -> bool
@abstract func activate() -> Action
