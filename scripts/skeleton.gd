@tool
class_name Skeleton
extends Actor

#ひたすら近づく
#隣接したら攻撃
#Actionを返す
func _ai_perform() -> Action:
	var target = map.get_player() as GridObject
	#print(grid_position,  " -> target(player) ", target.grid_position )
	var path_cells = map.get_point_path_to(grid_position,
					target.grid_position)#自分を含む座標ででてくる
	
	#到達できない
	if path_cells.is_empty():
		return MovementAction.new(Vector2i.ZERO)
		
	var offset:Vector2i = target.grid_position - grid_position
	var distance: int = abs(offset.x) + abs(offset.y)

	if distance==1:#近接したら攻撃
		return MeleeAction.new(target)		
	elif distance>5:#離れていたら動かない
		return 	MovementAction.new(Vector2i.ZERO)
	
	var destination := Vector2i(path_cells[1])
	var move_offset:Vector2i = destination - grid_position
	
	#移動先なにかいたら止まる
	if map.find_grid_object_at_location(destination, &"actor"):
		return MovementAction.new(Vector2i.ZERO)
	
	return MovementAction.new(move_offset)
	
	
func get_action() -> Action:
	return _ai_perform()

func died() -> void:
	print("%s is dead"% entity_name)
	remove_from_group("actor")
	remove_from_group("target")
