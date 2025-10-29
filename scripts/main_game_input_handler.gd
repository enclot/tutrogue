class_name MainGameInputHandler
extends Node

const INVENTORY_UI = preload("res://inventory_ui.tscn")
const SPECIFIABLE_POSITION_UI = preload("res://specifiable_position_ui.tscn")


const directions={
	"move_up":Vector2i.UP,
	"move_down":Vector2i.DOWN,
	"move_left":Vector2i.LEFT,
	"move_right":Vector2i.RIGHT,
	"move_up_left":Vector2i.UP+ Vector2i.LEFT,
	"move_up_right":Vector2i.UP+ Vector2i.RIGHT,
	"move_down_left":Vector2i.DOWN+ Vector2i.LEFT,
	"move_down_right":Vector2i.DOWN+ Vector2i.RIGHT,	
}

func get_action(player:Player) -> Action:
	var action: Action = null
	for direction in directions:
		if Input.is_action_just_pressed(direction):
			var offset: Vector2i = directions[direction]
			#action = MovementAction.new(player, offset)
			action = BumpAction.new(player, offset)
			
		elif Input.is_action_just_pressed("wait"):
			action = WaitAction.new(player)
			
		elif Input.is_action_just_pressed("item_pickup"):
			action = ItemPickupAction.new(player)
			
		elif Input.is_action_just_pressed("item_use"):
			action = await _with_pause(func() -> Variant:
				var selected_item:EntityResource = await _get_item("Item use", player)
				if not selected_item:
					return null

				var packed_scene: PackedScene = load(selected_item.scene_path)
				var item_actor:Actor = packed_scene.instantiate()
				item_actor.initialize()

				var specifiable_component:SpecifiableComponent = item_actor.get_component(SpecifiableComponent)
				if specifiable_component:
					var result := await _get_specifable_locations(player, specifiable_component)
					if not result:
						return null

				return ItemUseAction.new(player, item_actor)
			)
			
	return action


# インベントリを開いてアイテムのentityを取得 キャンセルはnull
func _get_item(window_title:String, player:Player) -> EntityResource:
	var inventory_ui: InventoryUI = INVENTORY_UI.instantiate()
	get_parent().add_child(inventory_ui)
	inventory_ui.build(window_title, player) #add_child()してからでないとinventory_uiの@onreadyが終わっていない
	
	return await inventory_ui.item_selected

func _with_pause(callback: Callable) -> Variant:
	get_tree().paused = true
	var result = await callback.call()
	get_tree().paused = false
	return result

func _get_specifable_locations(player:Player, specifiable:SpecifiableComponent) -> bool:
	var specified_position_ui:SpecifiedPositionUI = SPECIFIABLE_POSITION_UI.instantiate()
	get_parent().add_child(specified_position_ui)
	specified_position_ui.initialize(player, specifiable)
	return await specified_position_ui.position_selected
