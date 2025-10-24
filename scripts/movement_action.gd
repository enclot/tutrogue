class_name MovementAction
extends Action

var offset:Vector2i #移動量

func _init(_player:Player, _offset:Vector2i) -> void:
	player = _player
	offset = _offset
	

func perform() -> bool:
	print("MovementAction peform ", offset)
	return player.move(offset)
	
