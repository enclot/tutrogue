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
	var action:Action = input_handler.get_action(player)
	if action and action.perform():
		_handle_enemy_turns()
		map.update_fov(player)

func _handle_enemy_turns() -> void:
	var enemies = map.get_actors_in_group("enemy")
	for enemy in enemies:
		enemy.ai_perform()
