class_name ItemUseAction
extends Action

var item_actor:Actor
# itemを使う
func _init(_user_actor:Actor, _item_actor:Actor) -> void:
	self.item_actor = _item_actor
	actor = _user_actor
	
	
func perform() -> bool:
	#var specifiable:SpecifiableComponent = item_actor.get_component(SpecifiableComponent)
	#if specifiable and specifiable.target_positions.is_empty():
		#return false
	
	#itemはactivate()をもっているはず
	if item_actor.activate(actor):
		#使ったらinventoryから消す
		var inventory:InventoryComponent = actor.get_component(InventoryComponent)
		inventory.remove_item(item_actor.entity_resource)
		item_actor.queue_free()
		return true
	
	return false
		
	
