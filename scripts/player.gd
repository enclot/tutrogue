@tool
class_name Player extends Actor

signal action_selected(action: Action)

const INVENTORY_UI = preload("uid://b3j1v8q5565ry")
const POSITION_SELECT_UI = preload("uid://coqpmd2j7vcjr")

@export var last_used_stairs_resouce:StairsResource

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
		
		if await _try_activate(item):
			# 使用したアイテムをインベントリから削除
			inventory.remove_item(item)
		
	get_tree().paused = false
	
func _try_activate(_item:EntityResource)->bool:
	if not _item:
		return false

	var packed_scene: PackedScene = load(_item.scene_path)
	var selected = packed_scene.instantiate() as Item
	
	# TagetTypeがSELF以外は座標が必要
	if selected.target_type.select_mode!= TargetType.Mode.SELF:
		var pos_ui = POSITION_SELECT_UI.instantiate() as PositionSelectUI
		add_child(pos_ui) #playerの子に追加
		pos_ui.configure_target_type(selected.target_type)
		var positions:Array[Vector2i] = await pos_ui.positions_selected
		
		if selected.target_type.select_mode==TargetType.Mode.LINE:
			for i in range(positions.size()):
				if not map.is_walkable(positions[i]):
					positions = positions.slice(0, i)
					break
					
		selected.target_positions = positions
		
	if selected.can_use(self):
		action_selected.emit(selected.activate())
		return true
	return false
	
func died() -> void:
	print("player died")
	Gameplay.instance.show_gameover()
