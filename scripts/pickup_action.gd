class_name PickupAction extends Action

func perform(_actor:Actor) -> ActionResult:
	var objects = \
		_actor.map.get_grid_objects_at_location(_actor.grid_position)
	for obj in objects:
		if obj.is_in_group(&"pickup"):
			return _pickup(_actor, obj)
	return ActionResult.new(false)

func _pickup(_actor:Actor, _item:Item) -> ActionResult:
	var inventory:InventoryComponent = \
		_actor.get_component(InventoryComponent)
	if not inventory:
		return ActionResult.new(false)	
		
	if inventory.append_item(_item.entity_resource):
		print("%s pickuped."%_item.entity_name)
		_item.queue_free()
		return ActionResult.new(true)
	print("inventory is full.")
	return ActionResult.new(false)
