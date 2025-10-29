class_name MainGameInputHandler
extends Node

const INVENTORY_UI = preload("res://inventory_ui.tscn")


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
			get_tree().paused = true
			await _get_item("item use", player)
			get_tree().paused = false
			
	return action


# インベントリを開いてアイテムのentityを取得 キャンセルはnull
func _get_item(window_title:String, player:Player) -> EntityResource:
	var inventory_ui: InventoryUI = INVENTORY_UI.instantiate()
	get_parent().add_child(inventory_ui)
	inventory_ui.build(window_title, player) #add_child()してからでないとinventory_uiの@onreadyが終わっていない
	
	return await inventory_ui.item_selected
