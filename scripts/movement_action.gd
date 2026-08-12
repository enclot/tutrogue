class_name MovementAction
extends Action

var offset:Vector2i #移動量

func _init(_offset:Vector2i) -> void:
	offset = _offset

func perform(_player:Player) -> bool:
	print("MovementAction peform ", offset)
	return true
