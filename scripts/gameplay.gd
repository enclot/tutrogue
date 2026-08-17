class_name Gameplay
extends Node2D

static var instance:Gameplay

var current_level:BaseLevel

func _ready() -> void:
	instance = self
	
	current_level = get_child(0) as BaseLevel
	SceneManager.scene_added.connect(_on_level_added)	
	
func _on_level_added(level) -> void:
	if level is BaseLevel:
		current_level = level
		
func level1():
	SceneManager.swap_scenes("res://level_1.tscn", self, current_level)
	
func level2():
	SceneManager.swap_scenes("res://level_2.tscn", self, current_level)
