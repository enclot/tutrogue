@tool
class_name Javelin extends Item

func can_use(_user:Actor) -> bool:
	# 座標指定されていたら使える
	return not target_positions.is_empty()
	
func activate() -> Action:
	print("javelin activated")
	
	return RangedAction.new(target_positions, 50)
