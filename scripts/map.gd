class_name Map
extends Node2D


var cell_properties_map:CellPropertiesMap

@onready var tilemap: TileMapLayer = $TileMapLayer

func _ready() -> void:
	cell_properties_map = CellPropertiesMap.new(tilemap)

func is_walkable(_pos:Vector2i) -> bool:	
	return cell_properties_map.is_in_bounds(_pos) and \
		cell_properties_map.get_cell(_pos).is_walkable
