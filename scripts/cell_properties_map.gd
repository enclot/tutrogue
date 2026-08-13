class_name CellPropertiesMap
extends RefCounted

# セルの属性の集まり
var width:int
var height:int

var cells:Array[CellProperty]


func _init(_tilemap:TileMapLayer) -> void:
	var used_rect:Rect2i = _tilemap.get_used_rect()
	width = used_rect.size.x
	height = used_rect.size.y

	for y in height:
		for x in width:
			var data = _tilemap.get_cell_tile_data(Vector2i(x,y))
			var property = CellProperty.new(
				data.get_custom_data("walkable")
			)
			cells.append(property)	

func get_cell(_pos:Vector2i) ->CellProperty:
	return cells[_pos.x + width*_pos.y]

func is_in_bounds(_pos: Vector2i) -> bool:
	return (
		0 <= _pos.x
		and _pos.x < width
		and 0 <= _pos.y
		and _pos.y < height
		)
		
