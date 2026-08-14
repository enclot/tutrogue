class_name MeleeAction
extends Action

var target_actor:Actor

func _init(_target:Actor) -> void:
	target_actor = _target

func perform(attacker:Actor)->ActionResult:
	print("Melee %s -> %s"%[attacker.entity_name,
		 target_actor.entity_name])
	return ActionResult.new(true)
