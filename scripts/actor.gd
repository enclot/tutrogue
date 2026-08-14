@tool
@abstract class_name Actor 
extends GridObject

var map:Map
	
func initialize()->void:
	grid_position = Vector2i(position / Vector2(tile_size))
	
func _ready() -> void:
	initialize()
	sprite_2d.texture = entity_resource.texture

@abstract func get_action() -> Action
