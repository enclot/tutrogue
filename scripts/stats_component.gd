class_name StatsComponent
extends Component

signal hp_changed(hp, max_hp)

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
	# 死ぬactorはdied()を持ってる必要がある　actorの継承先で実装
	if actor and actor.has_method("died"):
		actor.died()

# ダメージを受ける側
func take_damage(damage:int) -> void:
	hp -= damage
	actor.take_damage()
		
# 回復
func heal(amount:int) -> void:
	hp += amount
