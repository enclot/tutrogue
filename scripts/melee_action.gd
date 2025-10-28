class_name MeleeAction
extends Action

var target_actor:Actor

func _init(attacker:Actor, target:Actor) -> void:
	actor = attacker
	target_actor = target

func perform()->bool:
	print("Melee %s -> %s"%[actor.entity_name, target_actor.entity_name])
	
	#actorがStatsComponentを持っていたら
	var target_stats:StatsComponent = target_actor.get_component(StatsComponent)
	var attacker_stats:StatsComponent = actor.get_component(StatsComponent)
	if target_stats and attacker_stats:
		target_stats.hp -= attacker_stats.power
		print("%s is damaged. current HP is %d"%[target_actor.entity_name, target_stats.hp])

	return true
