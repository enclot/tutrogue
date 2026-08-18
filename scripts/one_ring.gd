@tool
class_name OneRing extends Item

func can_use(_user:Actor) -> bool:
	return false
	
func activate() -> Action:
	#使えないので特に意味はないです
	return MovementAction.new(Vector2i.ZERO)
