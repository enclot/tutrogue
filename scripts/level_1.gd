class_name Level1
extends Node2D

@onready var input_handler: MainGameInputHandler = $MainGameInputHandler
@onready var player: Player = $Player
@onready var map: Map = $Map

func _ready() -> void:
	map.generate()

func _physics_process(_delta: float) -> void:
	var action:Action = input_handler.get_action(player)
	if action and action.perform():
		print("enemy turn")
