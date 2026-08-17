class_name GameInputHandler
extends Node

const DIRECTIONS = {
	&"move_up": Vector2i.UP,
	&"move_down": Vector2i.DOWN,
	&"move_left": Vector2i.LEFT,
	&"move_right": Vector2i.RIGHT,
}

signal action_selected(action:Action)
signal use_item_requested

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		for action:StringName in DIRECTIONS.keys():
			if event.is_action_pressed(action):
				var offset: Vector2i = DIRECTIONS[action]
				print(action, " -> ", offset)
				# ここでアクションを作成してaction_selectedを発火させる
				action_selected.emit(BumpAction.new(offset))
				break

		if event.is_action("item_use"):
			use_item_requested.emit()
		elif event.is_action("item_pickup"):
			action_selected.emit(PickupAction.new())
		elif Input.is_action_just_pressed("down_stairs"):
			action_selected.emit(StairsAction.new(Stairs.Direction.DOWN))
		elif Input.is_action_just_pressed("up_stairs"):
			action_selected.emit(StairsAction.new(Stairs.Direction.UP))
		elif Input.is_action_just_pressed("wait"):
			action_selected.emit(MovementAction.new(Vector2i.ZERO))
			
