class_name RangedAction extends Action

var positions:Array[Vector2i]
var amount:int

func _init(_positions:Array[Vector2i], _amount:int) -> void:
	positions = _positions
	amount = _amount
	
func perform(_actor:Actor) -> ActionResult:
	print("%s RangedAction peform"%[_actor.entity_name])
	if positions.is_empty():
		return ActionResult.new(false)

	#ダメージ処理
	for pos:Vector2i in positions:
		var target_actor:Actor = \
			_actor.map.find_grid_object_at_location(pos, &"actor")
		if target_actor:
			var target_stats:StatsComponent = \
				 target_actor.get_component(StatsComponent)
			if target_stats:
				target_stats.take_damage(amount)
				
	return ActionResult.new(true)
	
				
