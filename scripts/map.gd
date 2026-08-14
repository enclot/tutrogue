class_name Map
extends Node2D


var cell_properties_map:CellPropertiesMap

@onready var tilemap: TileMapLayer = $TileMapLayer

func _ready() -> void:
	cell_properties_map = CellPropertiesMap.new(tilemap)

func is_walkable(_pos:Vector2i) -> bool:	
	return cell_properties_map.is_in_bounds(_pos) and \
		cell_properties_map.get_cell(_pos).is_walkable

# grid_objectグループの中から指定座標にいるものを返す。無かったらnull
func get_grid_object_at_location(_pos:Vector2i) -> GridObject:
	var nodes = get_tree().get_nodes_in_group(&"grid_object")
	for node in nodes:
		var obj = node as GridObject
		if obj.grid_position == _pos:
			return obj
	return null
	
func get_player() -> Actor:
	return get_tree().get_first_node_in_group(&"player")
	
func get_point_path_to(
		from:Vector2i, to:Vector2i) -> PackedVector2Array:
	return cell_properties_map.pathfinder.get_point_path(from, to)
