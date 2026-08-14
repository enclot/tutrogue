class_name GameInputHandler
extends Node

const DIRECTIONS = {
	&"move_up": Vector2i.UP,
	&"move_down": Vector2i.DOWN,
	&"move_left": Vector2i.LEFT,
	&"move_right": Vector2i.RIGHT,
}

signal action_selected(Action)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		for action:StringName in DIRECTIONS.keys():
			if event.is_action_pressed(action):
				var offset: Vector2i = DIRECTIONS[action]
				print(action, " -> ", offset)
				# ここでアクションを作成してaction_selectedを発火させる
				action_selected.emit(BumpAction.new(offset))
				break
		if event.is_action_pressed("wait"):
			action_selected.emit(MovementAction.new(Vector2i.ZERO))
