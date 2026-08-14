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
	if target_stats:
		print("%s HP is %d"%
		[target_actor.entity_name,target_stats.hp])	
	return ActionResult.new(true)
