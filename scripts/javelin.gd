@tool
class_name Javelin
extends Actor

func activate(_user:Actor) -> bool:
	var specifiable_component:SpecifiableComponent = get_component(SpecifiableComponent)
	for target_position in specifiable_component.target_positions:
		var target_actor = _user.map.get_actor_at_location("enemy", target_position)
		
		if target_actor:
			#print(target_actor.entity_name)
			var target_stats:StatsComponent = target_actor.get_component(StatsComponent)
			target_stats.hp -= 100
	return true
