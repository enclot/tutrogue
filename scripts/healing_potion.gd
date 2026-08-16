@tool
class_name HealingPotion extends Item

func can_use(_user:Actor) -> bool:
	var user_stats:StatsComponent = _user.get_component(StatsComponent)
	if user_stats.hp == user_stats.max_hp:
		print("HP is max.")
		return false
	return true

func activate() -> Action:
	return HealingAction.new(100)
