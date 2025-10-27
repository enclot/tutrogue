@abstract class_name Action extends RefCounted

#var actor:Actor

#func _init(_actor:Actor) -> void:
	#actor = _actor

var actor:Actor

func _init(_actor:Actor) -> void:
	actor = _actor	

@abstract func perform() -> bool
