class_name Map
extends Node2D

var map_data:MapData

@onready var tile_map: TileMapLayer = $"../TileMapLayer"

func generate() -> void:
	map_data = MapData.new(tile_map)

func is_walkable(grid_postion:Vector2i) -> bool:
	return map_data.get_tile(grid_postion).is_walkable
