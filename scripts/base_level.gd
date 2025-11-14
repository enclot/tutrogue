class_name BaseLevel
extends Node2D

@onready var input_handler: MainGameInputHandler = $MainGameInputHandler
@onready var player: Player = $Map/Actors/Player
@onready var map: Map = $Map

func _ready() -> void:
	map.generate()
	map.update_fov(player)
	
	player.map = map
	
func reset_player() -> void:
	player = $Map/Actors/Player
	player.map = map
	
	var stairs = _find_stars_postion(player.last_use_stairs_direction,player.last_use_stairs_pair)
	if stairs:
		player.grid_position = stairs.grid_position
	
	map.update_fov(player)

		
func _input(_event: InputEvent) -> void:
	var action:Action = await input_handler.get_action(player)
	if action and action.perform():
		_handle_enemy_turns()
		map.update_fov(player)	

func _handle_enemy_turns() -> void:
	var enemies = map.get_actors_in_group("enemy")
	for enemy in enemies:
		var stats_component:StatsComponent = enemy.get_component(StatsComponent)
		if stats_component and not stats_component.is_alive():
			enemy.map.unregister_blocking_position(enemy.grid_position)
			continue
		enemy.ai_perform()

func _find_stars_postion(direction:Stairs.Direction, pair:Stairs.Pair) -> Stairs:
	#同じペア階段で、のぼってきたときはくだり、くだってきたときはのぼり階段をさがす
	var stairs_node = map.get_actors_in_group("stairs")
	for stairs:Stairs in stairs_node:
		if pair != stairs.pair:
			continue
		if direction != stairs.direction:
			return stairs
	return null
