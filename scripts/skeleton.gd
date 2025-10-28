@tool
class_name Skeleton
extends Actor


func ai_perform() -> bool:
	print("ai_perform ", entity_name)
	##var actor:Actor = owner.get_parent()
	var target = map.get_player_actor()
	var offset:Vector2i = target.grid_position - grid_position
	var distance:int = max(abs(offset.x),abs(offset.y))
	
	if distance==1:
		return MeleeAction.new(self, target).perform()
	elif distance>5:
		return WaitAction.new(self).perform()
	
	var path_cells = map.get_point_path_to(grid_position,target.grid_position)#自分を含む座標ででてくる

	if path_cells.size()<=1:
		return false
		
	var destination := Vector2i(path_cells[1])
	#destinationにべつのactorがいたらwait
	if map.get_actor_at_location("enemy",destination):
		return WaitAction.new(self).perform()
	
	var move_offset:Vector2i = destination - grid_position
	return MovementAction.new(self, move_offset).perform()

func died() -> void:
	print("%s is dead"% entity_name)
	sprite_2d.self_modulate = Color.RED
