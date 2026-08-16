@tool
@abstract class_name Item extends GridObject

@abstract func can_use(_user:Actor) -> bool
@abstract func activate() -> Action
