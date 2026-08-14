@tool
@abstract class_name Actor 
extends GridObject

var map:Map
	
func initialize()->void:
	grid_position = Vector2i(position / Vector2(tile_size))
	
func _ready() -> void:
	initialize()
	sprite_2d.texture = entity_resource.texture

@abstract func get_action() -> Action

func move(_offset:Vector2i) -> bool:
	var target_pos:Vector2i = grid_position +_offset
	if map.is_walkable(target_pos):
		grid_position = target_pos
		return true
	return false
