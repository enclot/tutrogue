@abstract class_name Action extends RefCounted

#var actor:Actor

#func _init(_actor:Actor) -> void:
	#actor = _actor

var player:Player

func _init(_player:Player) -> void:
	player = _player	

@abstract func perform() -> bool
