class_name StairsAction
extends Action

var input_direction:Stairs.Direction

func _init(_actor:Actor, _direction:Stairs.Direction) ->void:
	super._init(_actor)
	input_direction = _direction
	
func perform() -> bool:
	var stair_node:Stairs = actor.map.get_actor_at_location("stairs", actor.grid_position)
	if not stair_node:
		return false
	
	#階段の向きと、入力の向きが違ったらキャンセル
	if stair_node.direction != input_direction:
		return false
	
	Gameplay.instance.shift_level(input_direction)
	
	# 最後に使った階段を覚えておく
	if actor is Player:
		actor.last_use_stairs_direction = stair_node.direction
		actor.last_use_stairs_pair = stair_node.pair

	Gameplay.instance.save_level_actors()
	
	
	
	return false
