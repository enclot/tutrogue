class_name BumpAction
extends Action

var offset:Vector2i #移動量

func _init(_actor:Actor, _offset:Vector2i) -> void:
	super._init(_actor)
	offset = _offset
	
func _get_destination()->Vector2i:
	return actor.grid_position+offset
	
func perform() -> bool:
	var target_actor:Actor = actor.map.get_actor_at_location("target", _get_destination())
	if target_actor:
		return MeleeAction.new(actor, target_actor).perform()

	return MovementAction.new(actor, offset).perform()
