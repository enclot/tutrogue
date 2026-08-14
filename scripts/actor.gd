@tool
@abstract class_name Actor 
extends GridObject

var map:Map
	
var capabilities:Array[Component]

func initialize()->void:
	grid_position = Vector2i(position / Vector2(tile_size))
	
	for node in get_children():
		if node is Component:
			capabilities.append(node as Component)
	
func _ready() -> void:
	initialize()
	sprite_2d.texture = entity_resource.texture

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
	
	
