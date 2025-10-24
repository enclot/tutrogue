class_name TileState
extends Node2D

var is_walkable:bool = false

func _init(walkable:bool) -> void:
	is_walkable = walkable
