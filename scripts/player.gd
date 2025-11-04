@tool
class_name Player
extends Actor

var fov_radius:int = 8

@export var last_use_stairs_direction:Stairs.Direction
@export var last_use_stairs_pair:Stairs.Pair

func died() -> void:
	print("%s is dead"% entity_name)
	Gameplay.instance.save_level_actors()
	Gameplay.instance.show_gameover()
