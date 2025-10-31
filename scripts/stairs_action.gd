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
	if stair_node.stair != input_direction:
		return false
	
	print("direction=",input_direction)
	
	if input_direction == Stairs.Direction.UP:
		Gameplay.instance.level1()
	elif input_direction == Stairs.Direction.DOWN:
		Gameplay.instance.level2()
	
	Gameplay.instance.save_level_actors()
	return false
