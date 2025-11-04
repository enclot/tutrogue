class_name ItemDropAction
extends Action

var item_actor:Actor
# itemをおとす
func _init(_user_actor:Actor, _item_actor:Actor) -> void:
	self.item_actor = _item_actor
	actor = _user_actor
	
	
func perform() -> bool:
	item_actor.grid_position = actor.grid_position
	Gameplay.instance.add_actor(item_actor)
	#inventoryから消す
	var inventory:InventoryComponent = actor.get_component(InventoryComponent)
	inventory.remove_item(item_actor.entity_resource)
	return true

		
	
