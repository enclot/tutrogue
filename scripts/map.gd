class_name Map
extends Node2D


var properties_map:CellPropertiesMap

@onready var tilemap: TileMapLayer = $TileMapLayer
@onready var visibility_map: CellVisibilityMap = $VisibilityMap

var fov_system:FoVSystem

func _ready() -> void:
	properties_map = CellPropertiesMap.new(tilemap)

	var map_scale:Vector2 = tilemap.tile_set.tile_size
	visibility_map.initialize(properties_map.width,properties_map.height,map_scale)
	
	fov_system = FoVSystem.new(properties_map, visibility_map)
	
func is_walkable(_pos:Vector2i) -> bool:	
	return properties_map.is_in_bounds(_pos) and \
		properties_map.get_cell(_pos).is_walkable
		
func update_visibility(_player_pos:Vector2i) -> void:
	visibility_map.clear_visible_flags()
	var view_radius: int = 5 # プレイヤーの視野半径（マス数）
	fov_system.update_fov(_player_pos, view_radius)
	visibility_map.update()
