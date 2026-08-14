class_name StatsComponent
extends Component


@export_category("Stats")
@export var max_hp:int = 40
@export var hp:int = 40:
	set(value):
		hp = clampi(value, 0, max_hp)
		if hp == 0:
			_die()
@export var power:int=10

func is_alive() -> bool:
	return hp>0
	
func _die() -> void:
	# 死ぬactorはdied()を持ってる必要がある　actorの継承先で実装
	if actor and actor.has_method("died"):
		actor.died()
