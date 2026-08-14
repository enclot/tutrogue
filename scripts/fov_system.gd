class_name FoVSystem
extends RefCounted

const MULTIPLIERS = [
	[1, 0, 0, -1, -1, 0, 0, 1],
	[0, 1, -1, 0, 0, -1, 1, 0],
	[0, 1, 1, 0, 0, -1, -1, 0],
	[1, 0, 0, 1, -1, 0, 0, -1]
]

var properties_map:CellPropertiesMap
var visibility_map:CellVisibilityMap

func _init(_properties_map:CellPropertiesMap, _visibility_map:CellVisibilityMap) -> void:
	properties_map = _properties_map
	visibility_map = _visibility_map

func update_fov(origin:Vector2i,radius:int)->void:
	var start_cell: CellVisibility = visibility_map.get_cell(origin)
	start_cell.is_visible = true
	for i in 8:
		_cast_light(origin.x, origin.y, radius, 1, 1.0, 0.0,
		MULTIPLIERS[0][i], MULTIPLIERS[1][i], 
		MULTIPLIERS[2][i], MULTIPLIERS[3][i])

func _cast_light(cx:int,cy:int,radius:int,row:int,
		start_slope:float, end_slope:float,
		xx:int,xy:int,yx:int,yy:int) -> void:

	if start_slope<end_slope:
		return
	var next_start_slope:float = start_slope
	
	for i in range(row, radius+1):
		var blocked:bool = false
		var dy:int=-i
		for dx in range(-i,1):
			var l_slope: float = (dx - 0.5) / (dy + 0.5)
			var r_slope: float = (dx + 0.5) / (dy - 0.5)
			if start_slope < r_slope:
				continue
			elif end_slope > l_slope:
				break
			var sax: int = dx * xx + dy * xy
			var say: int = dx * yx + dy * yy
			if ((sax < 0 and absi(sax) > cx)or(say < 0 and absi(say) > cy)):
				continue
			var ax: int = cx + sax
			var ay: int = cy + say
			if ax >= properties_map.width or ay >= properties_map.height:
				continue
			var radius2: int = radius * radius
			var pos = Vector2i(ax, ay)
			var current_cell: CellProperty = properties_map.get_cell(pos)
			var visivility_cell:CellVisibility = visibility_map.get_cell(pos)

			if (dx * dx + dy * dy) < radius2:
				visivility_cell.is_visible = true
#
			if blocked:
				if current_cell.blocks_vision:
					next_start_slope = r_slope
					continue
				else:
					blocked = false
					start_slope = next_start_slope
			elif current_cell.blocks_vision:
				blocked = true
				next_start_slope = r_slope
				_cast_light(cx, cy, radius, i + 1, 
					start_slope,l_slope, xx, xy, yx, yy)
		if blocked:
			break
