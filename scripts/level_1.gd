class_name Level1
extends Node2D

@onready var input_handler: MainGameInputHandler = $MainGameInputHandler
@onready var player: Player = $Map/Actors/Player
@onready var map: Map = $Map

func _ready() -> void:
	map.generate()
	map.update_fov(player)
	
	player.map = map

func _physics_process(_delta: float) -> void:
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
