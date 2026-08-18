@tool
@abstract class_name Actor extends GridObject

var map:Map
	
var capabilities:Array[Component]

	
func _ready() -> void:
	for node in get_children():
		if node is Component:
			capabilities.append(node as Component)
			
	super()

@abstract func get_action() -> Action

func get_component(target_class:Variant) -> Component:
	for cap in capabilities:
		if is_instance_of(cap, target_class):
			return cap
	return null

func move(_offset:Vector2i) -> ActionResult:
	var target_pos:Vector2i = grid_position +_offset
	if map.is_walkable(target_pos):
		grid_position = target_pos
		return ActionResult.new(true)
	return ActionResult.new(false)
	
#表示
func take_damage() -> void:
	sprite_2d.self_modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	var stats = get_component(StatsComponent) as StatsComponent
	if stats.is_alive():
		sprite_2d.self_modulate = Color.WHITE
#表示	
func melee(_offset:Vector2i) -> void:
	var start_pos = sprite_2d.position
	var target_pos = start_pos + Vector2(_offset)*5
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite_2d, "position", target_pos, 0.08)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(sprite_2d, "position", start_pos, 0.08)
	
