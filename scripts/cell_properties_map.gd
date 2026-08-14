class_name CellPropertiesMap
extends RefCounted

# セルの属性の集まり
var width:int
var height:int

var cells:Array[CellProperty]

var pathfinder: AStarGrid2D 

func _init(_tilemap:TileMapLayer) -> void:
	var used_rect:Rect2i = _tilemap.get_used_rect()
	width = used_rect.size.x
	height = used_rect.size.y

	for y in height:
		for x in width:
			var data = _tilemap.get_cell_tile_data(Vector2i(x,y))
			var property = CellProperty.new(
				data.get_custom_data("walkable"),
				data.get_custom_data("blocks_vision")
			)
			cells.append(property)	
			
	_setup_pathfinding()

func get_cell(_pos:Vector2i) ->CellProperty:
	return cells[_pos.x + width*_pos.y]

func is_in_bounds(_pos: Vector2i) -> bool:
	return (
		0 <= _pos.x
		and _pos.x < width
		and 0 <= _pos.y
		and _pos.y < height
		)
		
func _setup_pathfinding() -> void:
	pathfinder = AStarGrid2D.new()
	pathfinder.region = Rect2i(0, 0, width, height)
	
	pathfinder.diagonal_mode = \
		AStarGrid2D.DIAGONAL_MODE_NEVER
	pathfinder.default_compute_heuristic = \
		AStarGrid2D.HEURISTIC_MANHATTAN
	pathfinder.default_estimate_heuristic = \
		AStarGrid2D.HEURISTIC_MANHATTAN
	
	pathfinder.update()
	for y in height:
		for x in width:
			var grid_position := Vector2i(x, y)
			pathfinder.set_point_solid(grid_position,
				not get_cell(grid_position).is_walkable)

func reset_navigation_costs() -> void:
	pathfinder.fill_weight_scale_region(pathfinder.region, 0.0)
	
func add_navigation_weight(_pos:Vector2i) -> void:
	pathfinder.set_point_weight_scale(_pos, 10.0)
