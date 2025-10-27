class_name MovementAction
extends Action

var offset:Vector2i #移動量

func _init(_actor:Actor, _offset:Vector2i) -> void:
	actor = _actor
	offset = _offset
	
func perform() -> bool:
	print("MovementAction peform ", offset)
	return actor.move(offset)
	
