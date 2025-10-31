class_name Map
extends Node2D

var map_data:MapData

@onready var tile_map: TileMapLayer = $"../TileMapLayer"
@onready var vision_tiles: Node2D = $VisionTiles

@onready var field_of_view: FieldOfView = $FieldOfView

@onready var actors_holder: Node2D = $Actors

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


#シーンビューに追加されたものからgroup名を使って取得する
func get_actors_in_group(group:String) -> Array[Actor]:
	var nodes = get_tree().get_nodes_in_group(group)
	var actors:Array[Actor] = []

	for node in nodes:
		if node is Actor:
			node.map = self
			actors.append(node)
	return actors
	
#なければnull
func get_actor_at_location(_group:String, _target_position:Vector2i) -> Actor:
	var actors = get_actors_in_group(_group)
	for actor:Actor in actors:
		if actor.grid_position == _target_position:
			return actor
	return null


func get_player_actor() -> Actor:
	var nodes = get_tree().get_nodes_in_group("player")
	if nodes:
		return nodes[0]
	return null

func get_point_path_to(from:Vector2i, to:Vector2i) -> PackedVector2Array:
	return map_data.pathfinder.get_point_path(from, to)


func register_blocking_position(_position:Vector2i) -> void:
	map_data.pathfinder.set_point_weight_scale(_position, 10.0)

func unregister_blocking_position(_position:Vector2i) -> void:
	map_data.pathfinder.set_point_weight_scale(_position, 0)
