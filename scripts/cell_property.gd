class_name CellProperty
extends RefCounted

var is_walkable:bool = false
var blocks_vision:bool = false

func _init(	_walkable:bool,
			_blocks_vision:bool) -> void:
	is_walkable = _walkable
	blocks_vision = _blocks_vision
