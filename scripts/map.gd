class_name Map
extends Node2D

var map_data:MapData

@onready var tile_map: TileMapLayer = $"../TileMapLayer"
@onready var vision_tiles: Node2D = $VisionTiles

@onready var field_of_view: FieldOfView = $FieldOfView

func generate() -> void:
	map_data = MapData.new(tile_map)
	
	_place_tiles()

func is_walkable(grid_postion:Vector2i) -> bool:
	return map_data.get_tile(grid_postion).is_walkable

func update_fov(player:Actor):
	field_of_view.update_fov(map_data, player.grid_position, player.fov_radius)

func _place_tiles() -> void:
	for tile in map_data.tile_state:
		vision_tiles.add_child(tile)
