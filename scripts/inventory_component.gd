class_name InventoryComponent
extends Component

@export var items:Array[EntityResource] =[]
@export var capacity:int = 2

	
func remove_item(item:EntityResource)->void:
	var idx = items.find(item)
	items.remove_at(idx)
	
func is_full()->bool:
	return items.size()>=capacity
	
func append_item(item:EntityResource)->void:
	items.append(item)

	
