@tool
class_name Player extends Actor

signal action_selected(action: Action)

const INVENTORY_UI = preload("uid://b3j1v8q5565ry")


var input_handler:GameInputHandler:
	set(value):
		input_handler = value
		input_handler.use_item_requested.connect(_on_use_item_requested)
		input_handler.action_selected.connect(action_selected.emit)

func get_action() -> Action:
	return await action_selected

func _on_use_item_requested()->void:
	get_tree().paused = true
	var ui = INVENTORY_UI.instantiate() as InventoryUI	
	add_child(ui)
	
	var inventory:InventoryComponent = \
		get_component(InventoryComponent)
	if inventory:
		ui.initialize("use", inventory.items)
		
	var item:EntityResource = await ui.item_selected
	# ここでItemUseActionをemitする
	if item:
		var packed_scene: PackedScene = load(item.scene_path)
		var item_scene = packed_scene.instantiate() as Item
		action_selected.emit(item_scene.activate())
	
	get_tree().paused = false
