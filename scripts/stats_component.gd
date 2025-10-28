class_name StatsComponent
extends Component

signal hp_changed(hp,max_hp)

@export_category("Stats")
@export var max_hp:int = 40
@export var hp:int = 40:
	set(value):
		hp = clampi(value, 0, max_hp)
		hp_changed.emit(hp, max_hp)
		if hp == 0:
			_die()
			
@export var power:int=10

func is_alive() -> bool:
	return hp>0
	
func _die() -> void:
	if actor and actor.has_method("died"):
		actor.remove_from_group("enemy")
		actor.remove_from_group("target")

		actor.z_index = -5
		actor.died()
	
