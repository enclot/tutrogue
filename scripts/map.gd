class_name Map
extends Node2D


var cell_properties_map:CellPropertiesMap

@onready var tilemap: TileMapLayer = $TileMapLayer
@onready var cell_visibility_map: CellVisibilityMap = $CellVisibilityMap

var fov_system:FoVSystem

func _ready() -> void:
	cell_properties_map = CellPropertiesMap.new(tilemap)
	
	var map_scale:Vector2 = tilemap.tile_set.tile_size
	cell_visibility_map.initialize(\
		cell_properties_map.width,cell_properties_map.height,map_scale)
	fov_system = FoVSystem.new(cell_properties_map, cell_visibility_map)

func is_walkable(_pos:Vector2i) -> bool:	
	return cell_properties_map.is_in_bounds(_pos) and \
		cell_properties_map.get_cell(_pos).is_walkable

func update_visibility(_player_pos:Vector2i) -> void:
	cell_visibility_map.clear_visible_flags()
	var view_radius: int = 5 # プレイヤーの視野半径（マス数）
	fov_system.update_fov(_player_pos, view_radius)
	cell_visibility_map.update()
	# 見えないGridObjectを表示しない
	for node in get_tree().get_nodes_in_group(&"grid_object"):
		var obj = node as GridObject
		var visibility = cell_visibility_map.get_cell(obj.grid_position)
		obj.visible = visibility.is_visible
	
# セルのgrid_object全部　無かったら空
func get_grid_objects_at_location(_pos:Vector2i)->Array[GridObject]:
	var result:Array[GridObject] = []
	for node in get_tree().get_nodes_in_group(&"grid_object"):
		var obj = node as GridObject
		if obj.grid_position == _pos:
			result.append(obj)
	return result
	
# セルの指定したグループのgrid_object1つ。無かったらnull	
func find_grid_object_at_location(
		_pos:Vector2i, _group:StringName) -> GridObject:
	for node in get_tree().get_nodes_in_group(_group):
		var obj = node as GridObject
		if obj.grid_position == _pos:
			return obj
	return null
	
func get_player() -> Actor:
	return get_tree().get_first_node_in_group(&"player")
	
func get_point_path_to(
		from:Vector2i, to:Vector2i) -> PackedVector2Array:
	return cell_properties_map.pathfinder.get_point_path(from, to)
	
func update_navigation_costs() -> void:
	cell_properties_map.reset_navigation_costs()
	for node in get_tree().get_nodes_in_group(&"actor"):
		var obj = node as GridObject
		cell_properties_map.add_navigation_weight(obj.grid_position)
