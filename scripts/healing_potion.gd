@tool
class_name HealingPotion
extends Actor

func activate(_user:Actor) -> bool:
	var stats = _user.get_component(StatsComponent)
	if stats:
		if stats.hp == stats.max_hp:
			print("hp is full ")
			return false
		
		print("%s use %s"%[_user.entity_name, entity_name])
		stats.hp += 100
	return true
