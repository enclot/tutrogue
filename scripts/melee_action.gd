class_name MeleeAction
extends Action

var target_actor:Actor

func _init(_target:Actor) -> void:
	target_actor = _target

func perform(attacker:Actor)->ActionResult:
	print("Melee %s -> %s"%[attacker.entity_name,
		 target_actor.entity_name])
		
	#actorがStatsComponentを持っていたら
	var target_stats:StatsComponent = \
		target_actor.get_component(StatsComponent)
	var attacker_stats:StatsComponent = \
		attacker.get_component(StatsComponent)
	if target_stats and attacker_stats:
		target_stats.take_damage(attacker_stats.power)
		#target_stats.hp -= attacker_stats.power
		print("%s is damaged. current HP is %d"%[
			target_actor.entity_name, target_stats.hp])
			
	return ActionResult.new(true)
