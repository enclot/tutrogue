class_name BumpAction
extends Action

var offset:Vector2i #移動量

func _init(_offset:Vector2i) -> void:
	offset = _offset

func perform(_actor:Actor) -> ActionResult:
	print("bump peform ", offset)
	var dest = _actor.grid_position + offset
	
	var objects = _actor.map.get_grid_objects_at_location(dest)
	for obj in objects:
		if obj.is_in_group(&"target"):
			print(obj.entity_name)
			return ActionResult.new(false,MeleeAction.new(obj))
	
	return ActionResult.new(false,MovementAction.new(offset))
