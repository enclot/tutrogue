class_name PickupAction extends Action

func perform(_actor:Actor) -> ActionResult:
	var objects = _actor.map.get_grid_objects_at_location(_actor.grid_position)
	for obj in objects:
		if obj.is_in_group(&"pickup"):
			print("%s pickuped."%obj.entity_name)
			return ActionResult.new(true)
	return ActionResult.new(false)
