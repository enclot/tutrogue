class_name ItemPickupAction
extends Action


func perform() -> bool:
	var inventory:InventoryComponent = actor.get_component(InventoryComponent)
	if not inventory:
		return false
		
	var item = actor.map.get_actor_at_location("item",actor.grid_position)
	if not item:
		return false
		
	if inventory.is_full():
		print("inventory is full")
		return false
		
	print("%s pickuped."%item.entity_name)
	inventory.append_item(item.entity_resource)
	item.queue_free()
	return true
