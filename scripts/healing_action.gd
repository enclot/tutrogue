class_name HealingAction extends Action

var amount:int = 0

func _init(_amount:int) -> void:
	amount = _amount

func perform(_actor:Actor) -> ActionResult:
	print("%s HealingAction peform %s"%[_actor.entity_name, amount])
	var stats:StatsComponent= _actor.get_component(StatsComponent)
	if stats:
		stats.heal(amount)
	return ActionResult.new(true)
