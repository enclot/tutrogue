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
	pass
	## 死ぬactorはdied()を持ってる必要がある　actorの継承先で実装
	#if actor and actor.has_method("died"):
		#actor.died()

# ダメージを受ける側
func take_damage() -> void:
	pass
	#var mat := actor.sprite_2d.material as ShaderMaterial
	#mat.set_shader_parameter("damage_flash",1.0)
	#await get_tree().create_timer(0.1).timeout
	#mat.set_shader_parameter("damage_flash",0.0)
	#
	##仮　ワープする
	#var respawn_pos = actor.map.get_open_location()
	#if respawn_pos:
		#actor.grid_position = respawn_pos	
	#
	##telagreaphを削除
	#var attack:AttackComponent = actor.get_component(AttackComponent)
	#if attack:
		#attack.cancel()

	# playerがダメージを受けたらシーンをリロード　それ以外は消す
	#if entity is Player:
		#get_tree().reload_current_scene()
	#else:
		#entity.queue_free()
