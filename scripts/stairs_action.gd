class_name StairsAction extends Action

var input_direction:Stairs.Direction

func _init(_direction:Stairs.Direction) ->void:
	input_direction = _direction
	
func perform(_actor:Actor) -> ActionResult:
	var stair:Stairs = _actor.map.find_grid_object_at_location(
		_actor.grid_position,&"stairs")
		
	if not stair:
		return ActionResult.new(false)
	
	#階段の向きと、入力の向きが違ったらキャンセル
	if stair.direction != input_direction:
		return ActionResult.new(false)
	
	print("direction=",input_direction)
	if input_direction == Stairs.Direction.UP:
		Gameplay.instance.level1()
	elif input_direction == Stairs.Direction.DOWN:
		Gameplay.instance.level2()

	return ActionResult.new(true)
