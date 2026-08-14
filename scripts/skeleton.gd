@tool
class_name Skeleton
extends Actor

func _ai_perform() -> Action:
	#ひたすら近づく
	#隣接したら攻撃
	#Actionを返す
	var target = map.get_player()
	var path_cells = map.get_point_path_to(grid_position,
					target.grid_position)#自分を含む座標ででてくる
	
	var offset:Vector2i = target.grid_position - grid_position
	var distance: int = abs(offset.x) + abs(offset.y)

	if distance==1:#近接したら攻撃
		return MeleeAction.new(target)		
		
	
	var destination := Vector2i(path_cells[1])
	var move_offset:Vector2i = destination - grid_position
	
	#移動先なにかいたら止まる
	if map.get_grid_object_at_location(destination):
		return MovementAction.new(Vector2i.ZERO)
	
	return MovementAction.new(move_offset)
	
	
func get_action() -> Action:
	return _ai_perform()
