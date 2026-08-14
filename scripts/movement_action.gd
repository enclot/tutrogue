class_name MovementAction
extends Action

var offset:Vector2i #移動量

func _init(_offset:Vector2i) -> void:
	offset = _offset

func perform(_actor:Actor) -> ActionResult:
	print("%s MovementAction peform %s"%[_actor.entity_name, offset])
	return _actor.move(offset)
