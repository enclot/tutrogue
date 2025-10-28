class_name MapData
extends RefCounted

var width: int
var height: int
var tile_state: Array[TileState]

var pathfinder: AStarGrid2D

# TileMapLayerから読み取る
func _init(tile_map:TileMapLayer) -> void:
	tile_state = []
	var tile_map_rect:Rect2i = tile_map.get_used_rect()
	width = tile_map_rect.end.x - tile_map_rect.position.x
	height = tile_map_rect.end.y - tile_map_rect.position.y
	
	for y in range(tile_map_rect.position.y, tile_map_rect.end.y):
		for x in range(tile_map_rect.position.x, tile_map_rect.end.x):
			var grid_position := Vector2i(x,y)
			var tile_data = tile_map.get_cell_tile_data(grid_position)
			if not tile_data:
				continue
			var tile_size = tile_map.tile_set.tile_size
			var new_tile = TileState.new(grid_position, tile_size,
										 tile_data.get_custom_data("transparent"), tile_data.get_custom_data("walkable"))

			tile_state.append(new_tile)

	_setup_pathfinding()
	
	
func is_in_bounds(coordinate: Vector2i) -> bool:
	return (
		0 <= coordinate.x
		and coordinate.x < width
		and 0 <= coordinate.y
		and coordinate.y < height
		)
		
func grid_to_index(grid_position: Vector2i) -> int:
	if not is_in_bounds(grid_position):
		return -1
	return grid_position.y * width + grid_position.x
	
func get_tile(grid_position: Vector2i) -> TileState:		
	var tile_index: int = grid_to_index(grid_position)
	if tile_index == -1:
		return null
	return tile_state[tile_index]

func get_tile_xy(x: int, y: int) -> TileState:
	var grid_position := Vector2i(x, y)
	return get_tile(grid_position)



func _setup_pathfinding() -> void:
	pathfinder = AStarGrid2D.new()
	pathfinder.region = Rect2i(0, 0, width, height)
	pathfinder.update()
	for y in height:
		for x in width:
			var grid_position := Vector2i(x, y)
			pathfinder.set_point_solid(grid_position, not get_tile(grid_position).is_walkable)
