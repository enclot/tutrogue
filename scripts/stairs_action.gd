class_name StairsAction extends Action

var input_direction:StairsResource.Direction

func _init(_direction:StairsResource.Direction) ->void:
	input_direction = _direction
	
func perform(_actor:Actor) -> ActionResult:
	var stairs:Stairs = _actor.map.find_grid_object_at_location(
		_actor.grid_position,&"stairs")
		
	if not stairs:
		return ActionResult.new(false)

	#出口をのぼったらゲームオーバー画面へ遷移
	if stairs.resource.direction==StairsResource.Direction.EXIT:
		if input_direction == StairsResource.Direction.UP:
			Gameplay.instance.show_gameover()

	#階段の向きと、入力の向きが違ったらキャンセル
	if stairs.resource.direction != input_direction:
		return ActionResult.new(false)
	
	if _actor is Player:
		_actor.last_used_stairs_resouce = stairs.resource
	
	Gameplay.instance.shift_level(input_direction)

	return ActionResult.new(true)
