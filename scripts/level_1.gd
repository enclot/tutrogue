class_name Level1
extends Node2D

@onready var player: Player = $Player
@onready var input_handler: GameInputHandler = $GameInputHandler
@onready var map: Map = $Map

func _ready() -> void:
	player.input_handler = input_handler
	player.map = map
	while true:
		var action:Action = await player.get_action()
		action.perform(player)
